# Chapter 2, §2.3.2 "Testing: Make It Central to Development" — one red–green
# TDD micro-cycle for the clinic-scheduling app's appointment-slot overlap check.
# Red: with the slots_overlap definition below removed, both tests error with
# NoMethodError (a NameError subclass): undefined method 'slots_overlap'.
# Green: with it in place, both tests pass. Run: ruby tdd_slots_overlap_test.rb
require "minitest/autorun"

def slots_overlap(a, b)
  a[0] < b[1] && b[0] < a[1]
end

class TestSlotsOverlap < Minitest::Test
  def test_overlapping_slots_conflict
    assert slots_overlap(["09:00", "09:30"], ["09:15", "09:45"])
  end

  def test_back_to_back_slots_do_not_conflict
    refute slots_overlap(["09:00", "09:30"], ["09:30", "10:00"])
  end
end
