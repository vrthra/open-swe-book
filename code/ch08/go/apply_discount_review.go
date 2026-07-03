// Chapter 8, Exercises §9 — the apply_discount code-review exercise, runnable.
// Two defects are planted ON PURPOSE; do not "fix" this file:
//  1. `math.Max(total, 0)` discards its result, so the clamp is a no-op.
//  2. `discounts.Lookup(code)` can return nil, and `.Percent` then panics.
//
// The exercise asks students to review the function and to run a linter over
// it. The checks below demonstrate both defects.
package main

import (
	"fmt"
	"math"
)

type Item struct {
	Price    float64
	Quantity int
}

type Cart struct {
	Items []Item
	Total float64
}

type Discount struct{ Percent float64 }

type Discounts struct{ table map[string]*Discount }

func (d *Discounts) Lookup(code string) *Discount { return d.table[code] }

var discounts = &Discounts{table: map[string]*Discount{
	"WELCOME10":  {Percent: 10},
	"BLOWOUT120": {Percent: 120},
}}

// Applies a discount code to a shopping cart and returns the new total.
func applyDiscount(cart *Cart, code string) float64 {
	total := 0.0
	for _, item := range cart.Items {
		total = total + item.Price*float64(item.Quantity)
	}
	discount := discounts.Lookup(code) // returns nil if code is unknown
	total = total - total*discount.Percent/100
	if total < 0 {
		math.Max(total, 0)
	}
	cart.Total = total
	return total
}

func newCart() *Cart { return &Cart{Items: []Item{{Price: 10.0, Quantity: 2}}} }

func main() {
	// The happy path works, which is how the defects survive casual testing.
	if got := applyDiscount(newCart(), "WELCOME10"); got != 18.0 {
		panic(fmt.Sprintf("want 18, got %g", got))
	}

	// Defect 1: an over-100% discount produces a negative total; the "clamp"
	// statement discards math.Max's result, so the negative value escapes.
	if got := applyDiscount(newCart(), "BLOWOUT120"); got != -4.0 {
		panic(fmt.Sprintf("want -4, got %g", got))
	}

	// Defect 2: an unknown code makes Lookup return nil, which is never checked.
	defer func() {
		if recover() == nil {
			panic("expected a nil-pointer panic on unknown code")
		}
		fmt.Println("both planted defects demonstrated")
	}()
	applyDiscount(newCart(), "NOSUCH")
}
