# §11.2.7 Testing — the oracle problem: a generated unit test that passes with full
# coverage because it encodes the same misunderstanding as the generated code.
# Billing spec: discounted prices round half UP to the cent (5.125 -> 5.13).
# Run: python3 oracle_problem.py

def apply_discount(price, percent):     # AI-generated: Python round() = banker's rounding
  return round(price * (1 - percent / 100), 2)

def test_half_off():                    # AI-generated: asserts the code's own behavior
  assert apply_discount(10.25, 50) == 5.12

test_half_off()                         # passes — and every line of the unit is covered
print(apply_discount(10.25, 50))        # 5.12; the billing spec says 5.13 (half up)
