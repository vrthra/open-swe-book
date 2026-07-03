# Chapter 8, Exercises §9 — the apply_discount code-review exercise, runnable.
# Two defects are planted ON PURPOSE; do not "fix" this file:
#   1. `total == 0` compares instead of assigning, so the clamp is a no-op.
#   2. `discounts.lookup(code)` can return None, and `.percent` then crashes.
# The exercise asks students to review the function and to run a linter or
# type checker over it. The asserts below demonstrate both defects.

from types import SimpleNamespace


class _Discounts:
  _table = {"WELCOME10": SimpleNamespace(percent=10),
       "BLOWOUT120": SimpleNamespace(percent=120)}

  def lookup(self, code):
    return self._table.get(code)


discounts = _Discounts()


# Applies a discount code to a shopping cart and returns the new total.
def apply_discount(cart, code):
  total = 0
  for item in cart.items:
    total = total + item.price * item.quantity
  discount = discounts.lookup(code)        # returns None if code is unknown
  total = total - total * discount.percent / 100
  if total < 0:
    total == 0
  cart.total = total
  return total


def _cart():
  return SimpleNamespace(items=[SimpleNamespace(price=10.0, quantity=2)],
             total=None)


# The happy path works, which is how the defects survive casual testing.
assert apply_discount(_cart(), "WELCOME10") == 18.0

# Defect 1: an over-100% discount produces a negative total; the "clamp"
# statement compares and discards, so the negative value escapes.
assert apply_discount(_cart(), "BLOWOUT120") == -4.0

# Defect 2: an unknown code makes lookup return None, which is never checked.
try:
  apply_discount(_cart(), "NOSUCH")
except AttributeError:
  pass
else:
  raise AssertionError("expected AttributeError on unknown code")

print("both planted defects demonstrated")
