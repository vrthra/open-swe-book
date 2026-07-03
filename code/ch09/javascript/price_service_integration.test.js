// §9.2.2 — PriceService plus the integration test that wires the real
// (object-backed) Catalog and Discounts components together.
const test = require("node:test");
const assert = require("node:assert/strict");

// Reduce price by percent (0..100). Throws RangeError on bad input.
function applyDiscount(price, percent) {
  if (price < 0) throw new RangeError("price must be non-negative");
  if (percent < 0 || percent > 100) throw new RangeError("percent must be in 0..100");
  return Math.round(price * (1 - percent / 100) * 100) / 100;
}

class Catalog {
  constructor(prices) { this.prices = prices; }        // name -> base price
  priceOf(item) { return this.prices[item]; }
}

class Discounts {
  constructor(percents) { this.percents = percents; }  // name -> percent off
  percentFor(item) { return this.percents[item] ?? 0; }
}

class PriceService {
  constructor(catalog, discounts) {
    this.catalog = catalog;        // unit A: name -> base price
    this.discounts = discounts;    // unit B: name -> percent off
  }

  quote(item) {
    const base = this.catalog.priceOf(item);
    const pct = this.discounts.percentFor(item);
    return applyDiscount(base, pct);
  }
}

test("quote integrates catalog and discounts", () => {
  const catalog = new Catalog({ mug: 12.0 });
  const discounts = new Discounts({ mug: 25 });
  const svc = new PriceService(catalog, discounts);
  assert.equal(svc.quote("mug"), 9.0);  // 12.0 * (1 - 0.25)
});
