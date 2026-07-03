// The minimal implementation that turns the run green (§2.3.2).
package slots

func slotsOverlap(a, b [2]string) bool {
	return a[0] < b[1] && b[0] < a[1]
}
