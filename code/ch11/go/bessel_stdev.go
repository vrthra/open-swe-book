// §11.7.1 Variance from the Mean — sample vs. population standard deviation
// on the running customer-found-defect dataset. Confirms the hand computation
// in the chapter: s = 5.85 (divide by n - 1), sigma = 5.58 (divide by n).
package main

import (
	"fmt"
	"math"
)

func main() {
	cfds := []float64{2, 4, 5, 5, 7, 8, 9, 10, 12, 14, 23}
	mean := 0.0
	for _, x := range cfds {
		mean += x
	}
	mean /= float64(len(cfds))
	ss := 0.0 // sum of squared deviations from the mean
	for _, x := range cfds {
		ss += (x - mean) * (x - mean)
	}

	s := math.Sqrt(ss / float64(len(cfds)-1)) // divides by n - 1 (Bessel)
	sigma := math.Sqrt(ss / float64(len(cfds)))

	fmt.Printf("s     = %.2f\n", s)     // 5.85 — matches the hand computation
	fmt.Printf("sigma = %.2f\n", sigma) // 5.58

	if fmt.Sprintf("%.2f %.2f", s, sigma) != "5.85 5.58" {
		panic("unexpected standard deviations")
	}
}
