// §9.3.1 — the statement/branch-coverage test pair for ClassifyAndSum.
package discount

import "testing"

func TestClassifyAndSum(t *testing.T) {
	cases := []struct {
		name string
		n    int
		want string
	}{
		{"T1: node 2 true edge", -5, "negative"},
		{"T2: loop runs three times", 3, "sum=6"},
		{"loop body never executes", 0, "sum=0"},
	}
	for _, c := range cases {
		if got := ClassifyAndSum(c.n); got != c.want {
			t.Errorf("%s: got %q, want %q", c.name, got, c.want)
		}
	}
}
