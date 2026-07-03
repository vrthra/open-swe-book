// §4.6.2 The Cocomo Family of Estimation Models — Basic COCOMO effort and
// schedule for the clinic scheduling app (organic mode: a = 2.4, b = 1.05).
package main

import (
	"fmt"
	"math"
)

func effort(kloc float64) float64 { return 2.4 * math.Pow(kloc, 1.05) } // organic
func schedule(e float64) float64  { return 2.5 * math.Pow(e, 0.38) }    // calendar months

func main() {
	e20, e40 := effort(20), effort(40)
	fmt.Printf("20 KLOC: %5.1f person-months, %.1f months\n", e20, schedule(e20))
	fmt.Printf("40 KLOC: %5.1f person-months, %.1f months\n", e40, schedule(e40))
	fmt.Printf("doubling factor: %.2f\n", e40/e20)

	// Checks against the chapter text.
	if fmt.Sprintf("%.0f %.1f %.2f", e20, e40, e40/e20) != "56 115.4 2.07" {
		panic("unexpected COCOMO numbers")
	}
}
