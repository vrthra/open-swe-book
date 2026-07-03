// §9.3.1 — the control-flow-graph worked example: classify a number and,
// for non-negative numbers, sum 1..n. Node comments match the CFG figure.
package discount

import "fmt"

func ClassifyAndSum(n int) string { // node 1  (entry)
	if n < 0 { // node 2  (decision)
		return "negative" // node 3
	}
	total := 0   // node 4
	i := 1       // node 4
	for i <= n { // node 5  (decision)
		total += i // node 6
		i++        // node 6
	}
	return fmt.Sprintf("sum=%d", total) // node 7  (exit)
}
