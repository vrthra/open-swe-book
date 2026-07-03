# §4.6.2 The Cocomo Family of Estimation Models — Basic COCOMO effort and
# schedule for the clinic scheduling app (organic mode: a = 2.4, b = 1.05).
from math import isclose


def effort(kloc, a=2.4, b=1.05):          # Basic COCOMO, organic
  return a * kloc ** b


def schedule(e):
  return 2.5 * e ** 0.38                # calendar months


e20, e40 = effort(20), effort(40)
print(f"20 KLOC: {e20:5.1f} person-months, {schedule(e20):.1f} months")
print(f"40 KLOC: {e40:5.1f} person-months, {schedule(e40):.1f} months")
print(f"doubling factor: {e40 / e20:.2f}")

# Checks against the chapter text.
assert round(e20) == 56                   # "~56 person-months"
assert round(e40, 1) == 115.4             # "≈ 115.4 person-months"
assert round(e40 / e20, 2) == 2.07        # "a factor of 2.07, not 2.0"
assert isclose(e40 / e20, 2 ** 1.05)      # the penalty is set by b alone
