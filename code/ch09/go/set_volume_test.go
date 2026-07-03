// §9.4.2 — equivalence-class representatives pass; the boundary test at 100
// fails against the buggy guard (here: asserts the bug is really there).
package discount

import "testing"

func TestSetVolumeBoundaries(t *testing.T) {
	accepted := []int{55, 1, 2, 99} // C2 representative + accepted boundaries
	for _, level := range accepted {
		if err := SetVolume(level); err != nil {
			t.Errorf("SetVolume(%d): unexpected rejection: %v", level, err)
		}
	}
	rejected := []int{-3, 250, 0, 101} // C1/C3 representatives + boundaries
	for _, level := range rejected {
		if err := SetVolume(level); err == nil {
			t.Errorf("SetVolume(%d): want rejection, got nil", level)
		}
	}
	// The payoff: the spec says 100 is valid, but the buggy guard rejects it,
	// so the boundary test at 100 FAILS — for exactly this reason.
	if err := SetVolume(100); err == nil {
		t.Error("the >= bug should reject 100; boundary test would catch it")
	}
}
