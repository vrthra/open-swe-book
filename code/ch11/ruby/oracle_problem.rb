# §11.2.7 Testing — the oracle problem: a generated unit test that passes with full
# coverage because it encodes the same misunderstanding as the generated code.
# Billing spec: discounted prices round half UP to the cent (5.125 -> 5.13).
# Run: ruby oracle_problem.rb

def apply_discount(price, percent)      # AI-generated: format %.2f rounds ties to
  format("%.2f", price * (1 - percent / 100.0))  # even — banker's rounding
end

def test_half_off                       # AI-generated: asserts the code's own behavior
  raise "test failed" unless apply_discount(10.25, 50) == "5.12"
end

test_half_off                           # passes — and every line of the unit is covered
puts apply_discount(10.25, 50)          # 5.12; the billing spec says 5.13 (half up)
