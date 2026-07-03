# §9.2.1 Unit Testing — the three test doubles (stub, mock, fake) standing in
# for the discounts dependency of PriceService (defined in §9.2.2, included
# here so the file runs standalone with `ruby test_doubles.rb`).

# Reduce price by percent (0..100). Raises ArgumentError on bad input.
def apply_discount(price, percent)
  raise ArgumentError, "price must be non-negative" if price < 0
  raise ArgumentError, "percent must be in 0..100" unless (0..100).cover?(percent)
  (price * (1 - percent / 100.0)).round(2)
end

class PriceService
  def initialize(catalog, discounts)
    @catalog = catalog        # unit A: name -> base price
    @discounts = discounts    # unit B: name -> percent off
  end

  def quote(item)
    apply_discount(@catalog.price_of(item), @discounts.percent_for(item))
  end
end

# --- stub: canned answers, nothing more ---
class StubCatalog
  def price_of(item) = 12.0        # every item costs 12.0
end

class StubDiscounts
  def percent_for(item) = 25       # canned answer, whatever the item
end

svc = PriceService.new(StubCatalog.new, StubDiscounts.new)
raise unless svc.quote("mug") == 9.0             # 12.0 * (1 - 0.25)

# --- mock: records the interaction so the test can assert on it ---
class MockDiscounts
  attr_reader :calls
  def initialize = @calls = []
  def percent_for(item)
    @calls << item
    25
  end
end

mock = MockDiscounts.new
PriceService.new(StubCatalog.new, mock).quote("mug")
raise unless mock.calls == ["mug"]               # called exactly once, with "mug"

# --- fake: a lightweight working implementation ---
class FakeDiscounts
  def initialize(table) = @table = table.dup     # in-memory stand-in
  def percent_for(item) = @table.fetch(item, 0)
end

svc = PriceService.new(StubCatalog.new, FakeDiscounts.new("mug" => 25))
raise unless svc.quote("mug") == 9.0
raise unless svc.quote("bowl") == 12.0           # unknown item: no discount

puts "stub, mock, and fake examples all passed"
