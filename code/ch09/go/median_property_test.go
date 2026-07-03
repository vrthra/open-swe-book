// §9.1.4 Test Oracles — property oracle for median(xs). The book shows this
// with rapid (pgregory.net/rapid, verified separately); to keep this module
// free of third-party deps, the same two properties run here under the
// standard library's testing/quick.

package discount

import (
	"slices"
	"testing"
	"testing/quick"
)

func median(xs []int) int {
	ys := slices.Clone(xs)
	slices.Sort(ys)
	return ys[len(ys)/2] // middle element (upper median)
}

func TestMedianProperties(t *testing.T) {
	props := func(xs []int) bool {
		if len(xs) == 0 {
			return true // the properties are over non-empty lists
		}
		m := median(xs)
		rev := slices.Clone(xs)
		slices.Reverse(rev)
		return m == median(rev) && // order independence
			slices.Contains(xs, m) // the median is one of the inputs
	}
	if err := quick.Check(props, &quick.Config{MaxCount: 10_000}); err != nil {
		t.Error(err)
	}
}
