// Chapter 8, Exercises §9 — the apply_discount code-review exercise, runnable.
// Two defects are planted ON PURPOSE; do not "fix" this file:
//   1. `total == 0;` compares instead of assigning, so the clamp is a no-op
//      (eslint 10.6.0, no-unused-expressions: "Expected an assignment or
//      function call and instead saw an expression").
//   2. `discounts.lookup(code)` can return null, and `.percent` then throws.
// The exercise asks students to review the function and to run a linter over
// it. The asserts below demonstrate both defects.

const assert = require("node:assert");

const discounts = {
  table: { WELCOME10: { percent: 10 }, BLOWOUT120: { percent: 120 } },
  lookup(code) { return this.table[code] ?? null; },
};

// Applies a discount code to a shopping cart and returns the new total.
function applyDiscount(cart, code) {
  let total = 0;
  for (const item of cart.items) {
    total = total + item.price * item.quantity;
  }
  const discount = discounts.lookup(code);   // returns null if code is unknown
  total = total - total * discount.percent / 100;
  if (total < 0) {
    total == 0;
  }
  cart.total = total;
  return total;
}

function cart() {
  return { items: [{ price: 10.0, quantity: 2 }], total: null };
}

// The happy path works, which is how the defects survive casual testing.
assert.equal(applyDiscount(cart(), "WELCOME10"), 18.0);

// Defect 1: an over-100% discount produces a negative total; the "clamp"
// statement compares and discards, so the negative value escapes.
assert.equal(applyDiscount(cart(), "BLOWOUT120"), -4.0);

// Defect 2: an unknown code makes lookup return null, which is never checked.
assert.throws(() => applyDiscount(cart(), "NOSUCH"), TypeError);

console.log("both planted defects demonstrated");
