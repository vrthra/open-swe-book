// Chapter 8, §8.4.1 (type checkers) — a string price flows into arithmetic.
// go build rejects this file; it never runs (go 1.26):
// ./line_total_type_fault.go:15:21: cannot use price (variable of type
// string) as float64 value in argument to lineTotal
package main

import "fmt"

func lineTotal(price float64, quantity int) float64 {
	return price * float64(quantity)
}

func main() {
	price := "9.99" // read from a CSV row, still a string
	total := lineTotal(price, 3)
	fmt.Println(total) // never runs: go build rejects the call
}
