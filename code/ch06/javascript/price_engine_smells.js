// Chapter 6, exercises.md exercise 6 — PriceEngine listing exhibiting coupling smells
// (content, common, and control coupling) for students to critique. The smells are
// deliberate; do not imitate this design.
// Run: node price_engine_smells.js
const assert = require("node:assert");

let lastTotal = 0.0;                      // read by Checkout and Receipt

class Cart {
  constructor() { this._items = []; }
}

class PriceEngine {
  compute(cart, isB2b) {
    cart._items.sort((a, b) => a.qty - b.qty);  // reaches into Cart's internals
    let total = 0.0;
    for (const item of cart._items) {
      if (isB2b) {
        total += item.wholesale * item.qty * 0.9;
      } else {
        total += item.retail * item.qty;
      }
    }
    lastTotal = total;
  }
}

class Receipt {
  render() { return `Total: $${lastTotal.toFixed(2)}`; }
}

// Demonstration that the listing runs (students critique the design above).
const cart = new Cart();
cart._items = [
  { qty: 2, retail: 5.00, wholesale: 4.00 },
  { qty: 1, retail: 12.50, wholesale: 10.00 },
];
new PriceEngine().compute(cart, false);
assert.strictEqual(lastTotal, 22.50);
assert.strictEqual(new Receipt().render(), "Total: $22.50");

new PriceEngine().compute(cart, true);
assert.ok(Math.abs(lastTotal - 16.20) < 1e-9);  // (2*4.00 + 1*10.00) * 0.9
console.log("retail total 22.50, b2b total 16.20: OK");
