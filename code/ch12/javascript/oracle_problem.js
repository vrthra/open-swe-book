// §12.2.7 Testing — the oracle problem: a generated unit test that passes with full
// coverage because it encodes the same misunderstanding as the generated code.
// Billing spec: discounted prices round half UP to the cent (8.575 -> 8.58).
// Run: node oracle_problem.js

const assert = require("node:assert");

function applyDiscount(price, percent) {  // AI-generated: toFixed(2) rounds the stored
  return Number((price * (1 - percent / 100)).toFixed(2)); // double: 8.575 is 8.5749…
}

function testHalfOff() {                  // AI-generated: asserts the code's own behavior
  assert.strictEqual(applyDiscount(17.15, 50), 8.57);
}

testHalfOff();                           // passes — and every line of the unit is covered
console.log(applyDiscount(17.15, 50));   // 8.57; the billing spec says 8.58 (half up)
