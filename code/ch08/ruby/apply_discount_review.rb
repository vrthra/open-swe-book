# Chapter 8, Exercises §9 — the apply_discount code-review exercise, runnable.
# Two defects are planted ON PURPOSE; do not "fix" this file:
#   1. `total == 0` compares instead of assigning, so the clamp is a no-op.
#      Subtle: as the last expression of the `if` body it counts as a value,
#      so even `ruby -w` and RuboCop's Lint/Void stay silent here.
#   2. `DISCOUNTS.lookup(code)` can return nil, and `.percent` then raises.
# The exercise asks students to review the function and to run a linter over
# it. The checks below demonstrate both defects.

Discount = Struct.new(:percent)

class DiscountTable
  TABLE = { "WELCOME10" => Discount.new(10),
            "BLOWOUT120" => Discount.new(120) }.freeze

  def lookup(code)
    TABLE[code]
  end
end

DISCOUNTS = DiscountTable.new

# Applies a discount code to a shopping cart and returns the new total.
def apply_discount(cart, code)
  total = 0
  cart.items.each do |item|
    total = total + item.price * item.quantity
  end
  discount = DISCOUNTS.lookup(code)        # returns nil if code is unknown
  total = total - total * discount.percent / 100
  if total < 0
    total == 0
  end
  cart.total = total
  total
end

Item = Struct.new(:price, :quantity)
Cart = Struct.new(:items, :total)

def build_cart
  Cart.new([Item.new(10.0, 2)], nil)
end

# The happy path works, which is how the defects survive casual testing.
raise unless apply_discount(build_cart, "WELCOME10") == 18.0

# Defect 1: an over-100% discount produces a negative total; the "clamp"
# statement compares and discards, so the negative value escapes.
raise unless apply_discount(build_cart, "BLOWOUT120") == -4.0

# Defect 2: an unknown code makes lookup return nil, which is never checked.
begin
  apply_discount(build_cart, "NOSUCH")
  raise "expected NoMethodError on unknown code"
rescue NoMethodError
  puts "both planted defects demonstrated"
end
