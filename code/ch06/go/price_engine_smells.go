// Chapter 6, exercises.md exercise 6 — PriceEngine listing exhibiting coupling smells
// (content, common, and control coupling) for students to critique. The smells are
// deliberate; do not imitate this design.
// Run: go run price_engine_smells.go
package main

import (
	"fmt"
	"math"
	"slices"
)

var lastTotal = 0.0 // read by Checkout and Receipt

type Item struct {
	Qty               int
	Retail, Wholesale float64
}
type Cart struct{ items []Item } // unexported — meant to be Cart's secret

type PriceEngine struct{}

func (PriceEngine) Compute(cart *Cart, isB2B bool) {
	slices.SortFunc(cart.items, func(a, b Item) int { return a.Qty - b.Qty })
	total := 0.0
	for _, item := range cart.items {
		if isB2B {
			total += item.Wholesale * float64(item.Qty) * 0.9
		} else {
			total += item.Retail * float64(item.Qty)
		}
	}
	lastTotal = total
}

// The receipt, adapted to a plain function in Go — still reads the package global.
func RenderReceipt() string { return fmt.Sprintf("Total: $%.2f", lastTotal) }

// Demonstration that the listing runs (students critique the design above).
func main() {
	cart := &Cart{items: []Item{
		{Qty: 2, Retail: 5.00, Wholesale: 4.00},
		{Qty: 1, Retail: 12.50, Wholesale: 10.00},
	}}
	engine := PriceEngine{}
	engine.Compute(cart, false)
	if lastTotal != 22.50 || RenderReceipt() != "Total: $22.50" {
		panic("retail total wrong")
	}
	engine.Compute(cart, true)
	if math.Abs(lastTotal-16.20) > 1e-9 { // (2*4.00 + 1*10.00) * 0.9
		panic("b2b total wrong")
	}
	fmt.Println("retail total 22.50, b2b total 16.20: OK")
}
