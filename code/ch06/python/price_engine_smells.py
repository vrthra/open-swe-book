# Chapter 6, exercises.md exercise 6 — PriceEngine listing exhibiting coupling smells
# (content, common, and control coupling) for students to critique. The smells are
# deliberate; do not imitate this design.
# Run: python3 price_engine_smells.py
LAST_TOTAL = 0.0                          # read by Checkout and Receipt


class Cart:
  def __init__(self):
    self._items = []


class PriceEngine:
  def compute(self, cart, is_b2b):
    global LAST_TOTAL
    cart._items.sort(key=lambda i: i["qty"])
    total = 0.0
    for item in cart._items:
      if is_b2b:
        total += item["wholesale"] * item["qty"] * 0.9
      else:
        total += item["retail"] * item["qty"]
    LAST_TOTAL = total


class Receipt:
  def render(self):
    return f"Total: ${LAST_TOTAL:.2f}"


# Demonstration that the listing runs (students critique the design above).
cart = Cart()
cart._items = [
  {"qty": 2, "retail": 5.00, "wholesale": 4.00},
  {"qty": 1, "retail": 12.50, "wholesale": 10.00},
]
PriceEngine().compute(cart, is_b2b=False)
assert LAST_TOTAL == 22.50
assert Receipt().render() == "Total: $22.50"

PriceEngine().compute(cart, is_b2b=True)
assert abs(LAST_TOTAL - 16.20) < 1e-9      # (2*4.00 + 1*10.00) * 0.9
print("retail total 22.50, b2b total 16.20: OK")
