// Chapter 8, §8.4.1 (data-flow analyzers) — a resource leaked on one path.
// The file is opened near the top of exportPrices and closed at the bottom,
// but the error-path `return` in between skips the close. go vet has no
// unclosed-file check and stays silent; GoLand 2025.3's resource-leak
// inspection walks every path and flags the early return that skips Close.
// The checks below prove the leak at runtime by counting open descriptors.
package main

import (
	"fmt"
	"maps"
	"math"
	"os"
	"path/filepath"
	"slices"
)

// Discounts is the same stand-in as Chapter 9, §9.3.
type Discounts struct{ table map[string]int }

func (d *Discounts) PercentFor(item string) int { return d.table[item] }

func exportPrices(catalog map[string]float64, disc *Discounts, path string) string {
	out, _ := os.Create(path)
	out.WriteString("item,price\n")
	for _, item := range slices.Sorted(maps.Keys(catalog)) {
		pct := disc.PercentFor(item)
		if pct < 0 || pct > 100 {
			return "" // error path: `out` is never closed
		}
		final := math.Round(catalog[item]*(1-float64(pct)/100)*100) / 100
		fmt.Fprintf(out, "%s,%g\n", item, final)
	}
	out.Close()
	return path
}

func openDescriptors() int {
	entries, err := os.ReadDir("/proc/self/fd") // Linux-only census
	if err != nil {
		panic(err)
	}
	return len(entries)
}

func main() {
	path := filepath.Join(os.TempDir(), "ch08-prices.csv")

	// Normal path: file written and closed.
	catalog := map[string]float64{"mug": 10.0, "bowl": 12.0}
	disc := &Discounts{table: map[string]int{"mug": 25}}
	if got := exportPrices(catalog, disc, path); got != path {
		panic("expected the path back on the normal path")
	}
	data, _ := os.ReadFile(path)
	if string(data) != "item,price\nbowl,12\nmug,7.5\n" {
		panic("unexpected file contents: " + string(data))
	}

	// Error path: a 120% discount triggers the early return and leaks the handle.
	before := openDescriptors()
	bad := &Discounts{table: map[string]int{"mug": 120}}
	if got := exportPrices(map[string]float64{"mug": 10.0}, bad, path); got != "" {
		panic("expected the error path")
	}
	if after := openDescriptors(); after != before+1 {
		panic(fmt.Sprintf("expected one leaked descriptor, got %d", after-before))
	}
	fmt.Println("leak confirmed on the error path; normal path wrote the file")
}
