# §9.4.2 — the buggy boundary guard (`>=` where the spec demands `>`), plus a
# demonstration that the boundary test at 100 fails against it while the
# equivalence-class representatives all pass.

def apply(level)
  @current = level
end

def set_volume(level)
  if !level.is_a?(Integer) || level < 1 || level >= 100   # BUG: >= should be >
    raise ArgumentError, "level must be 1..100"
  end
  apply(level)
end

def rejected?(level)
  set_volume(level)
  false
rescue ArgumentError
  true
end

raise "C2 broken" if rejected?(55)          # C2 representative: accepted — bug hides
raise "C1 broken" unless rejected?(-3)      # C1 representative: rejected
raise "C3 broken" unless rejected?(250)     # C3 representative: rejected
raise "C4 broken" unless rejected?("loud") && rejected?(3.5)  # non-integer: rejected
raise "0 broken" unless rejected?(0)        # just below lower boundary: rejected
raise "accepts broken" if rejected?(1) || rejected?(2) || rejected?(99)
raise "101 broken" unless rejected?(101)    # just above upper boundary: rejected
# The payoff: the spec says 100 is valid, but the buggy guard rejects it, so
# the boundary test `set_volume(100)` FAILS — for exactly this reason.
raise "boundary test at 100 should expose the >= bug" unless rejected?(100)
puts "boundary test set_volume(100) fails against the buggy guard"
