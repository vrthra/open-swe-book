# Chapter 6, exercises.md exercise 6 — PriceEngine listing exhibiting coupling smells
# (content, common, and control coupling) for students to critique. The smells are
# deliberate; do not imitate this design.
# Run: ruby price_engine_smells.rb
$last_total = 0.0                      # read by Checkout and Receipt

class Cart
  def initialize = @items = []
end

class PriceEngine
  def compute(cart, is_b2b)
    items = cart.instance_variable_get(:@items)  # digs into Cart's internals
    items.sort_by! { |i| i[:qty] }
    total = 0.0
    items.each do |item|
      if is_b2b
        total += item[:wholesale] * item[:qty] * 0.9
      else
        total += item[:retail] * item[:qty]
      end
    end
    $last_total = total
  end
end

class Receipt
  def render = format("Total: $%.2f", $last_total)
end

# Demonstration that the listing runs (students critique the design above).
cart = Cart.new
cart.instance_variable_set(:@items, [
  { qty: 2, retail: 5.00, wholesale: 4.00 },
  { qty: 1, retail: 12.50, wholesale: 10.00 }
])
PriceEngine.new.compute(cart, false)
raise unless $last_total == 22.50
raise unless Receipt.new.render == "Total: $22.50"

PriceEngine.new.compute(cart, true)
raise unless ($last_total - 16.20).abs < 1e-9  # (2*4.00 + 1*10.00) * 0.9
puts "retail total 22.50, b2b total 16.20: OK"
