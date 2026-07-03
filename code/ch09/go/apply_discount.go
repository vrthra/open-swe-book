// Package discount holds the flagship apply-discount unit under test (§9.2.1).
package discount

import (
	"errors"
	"math"
)

// ApplyDiscount reduces price by percent (0..100). Returns an error on bad input.
func ApplyDiscount(price, percent float64) (float64, error) {
	if price < 0 {
		return 0, errors.New("price must be non-negative")
	}
	if percent < 0 || percent > 100 {
		return 0, errors.New("percent must be in 0..100")
	}
	return math.Round(price*(1-percent/100)*100) / 100, nil
}
