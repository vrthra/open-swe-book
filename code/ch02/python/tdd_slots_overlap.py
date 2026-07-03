# Chapter 2, §2.3.2 "Testing: Make It Central to Development" — one red–green
# TDD micro-cycle for the clinic-scheduling app's appointment-slot overlap check.
# Red: with the slots_overlap definition below removed, running this file fails
# with NameError: name 'slots_overlap' is not defined.
# Green: with it in place, both tests pass. Run: python3 tdd_slots_overlap.py

def slots_overlap(a, b):
  return a[0] < b[1] and b[0] < a[1]

def test_overlapping_slots_conflict():
  assert slots_overlap(("09:00", "09:30"), ("09:15", "09:45"))

def test_back_to_back_slots_do_not_conflict():
  assert not slots_overlap(("09:00", "09:30"), ("09:30", "10:00"))

test_overlapping_slots_conflict()
test_back_to_back_slots_do_not_conflict()
print("2 tests passed")
