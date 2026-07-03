// §11.2.7 Testing — the oracle problem: a generated unit test that passes with full
// coverage because it encodes the same misunderstanding as the generated code.
// Billing spec: discounted prices round half UP to the cent (5.125 -> 5.13).
// Run: go run oracle_problem.go

package main

import "fmt"

func applyDiscount(price, percent float64) string { // AI-generated: %.2f rounds ties
	return fmt.Sprintf("%.2f", price*(1-percent/100)) // to even — banker's rounding
}

func testHalfOff() { // AI-generated: asserts the code's own behavior
	if applyDiscount(10.25, 50) != "5.12" {
		panic("testHalfOff failed")
	}
}

func main() {
	testHalfOff()                         // passes — and every line of the unit is covered
	fmt.Println(applyDiscount(10.25, 50)) // 5.12; the billing spec says 5.13 (half up)
}
