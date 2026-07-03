# §9.2.2 — PriceService plus the integration test that wires the real
# (hash-backed) Catalog and Discounts components together.
require "minitest/autorun"

# Reduce price by percent (0..100). Raises ArgumentError on bad input.
def apply_discount(price, percent)
  raise ArgumentError, "price must be non-negative" if price < 0
  raise ArgumentError, "percent must be in 0..100" unless (0..100).cover?(percent)
  (price * (1 - percent / 100.0)).round(2)
end

class Catalog
  def initialize(prices)
    @prices = prices              # name -> base price
  end

  def price_of(item) = @prices.fetch(item)
end

class Discounts
  def initialize(percents)
    @percents = percents          # name -> percent off
  end

  def percent_for(item) = @percents.fetch(item, 0)
end

class PriceService
  def initialize(catalog, discounts)
    @catalog = catalog        # unit A: name -> base price
    @discounts = discounts    # unit B: name -> percent off
  end

  def quote(item)
    base = @catalog.price_of(item)
    pct = @discounts.percent_for(item)
    apply_discount(base, pct)
  end
end

class TestPriceServiceIntegration < Minitest::Test
  def test_quote_integrates_catalog_and_discounts
    catalog = Catalog.new({ "mug" => 12.0 })
    discounts = Discounts.new({ "mug" => 25 })
    svc = PriceService.new(catalog, discounts)
    assert_equal(9.0, svc.quote("mug"))  # 12.0 * (1 - 0.25)
  end
end
