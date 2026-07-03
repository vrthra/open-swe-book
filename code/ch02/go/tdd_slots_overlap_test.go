// Chapter 2, §2.3.2 "Testing: Make It Central to Development" — one red–green
// TDD micro-cycle for the clinic-scheduling app's appointment-slot overlap check.
// Red: with tdd_slots_overlap.go removed, `go test` fails to build with
// "undefined: slotsOverlap" (Go's red is a compile error).
// Green: with it in place, both tests pass. Run: go test ./...
package slots

import "testing"

func TestOverlappingSlotsConflict(t *testing.T) {
	if !slotsOverlap([2]string{"09:00", "09:30"}, [2]string{"09:15", "09:45"}) {
		t.Error("want overlapping slots to conflict")
	}
}

func TestBackToBackSlotsDoNotConflict(t *testing.T) {
	if slotsOverlap([2]string{"09:00", "09:30"}, [2]string{"09:30", "10:00"}) {
		t.Error("want back-to-back slots not to conflict")
	}
}
