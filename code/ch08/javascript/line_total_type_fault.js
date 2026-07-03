// Chapter 8, §8.4.1 (type checkers) — a string price flows into arithmetic.
// node runs this file without complaint; * coerces "9.99" to a number, so the
// arithmetic silently "works" here — pass "abc" instead and you get NaN.
// tsc rejects the call before it runs (tsc 6.0.3, --allowJs --checkJs):
//   line_total_type_fault.js(18,25): error TS2345: Argument of type 'string'
//   is not assignable to parameter of type 'number'.
// @ts-check
/**
 * @param {number} price
 * @param {number} quantity
 * @returns {number}
 */
function lineTotal(price, quantity) {
  return price * quantity;
}

const price = "9.99";       // read from a CSV row, still a string
const total = lineTotal(price, 3);
console.log(total);         // no crash: JS coerces and prints 29.97

// Runner boilerplate (trimmed from the book fence).
// @ts-ignore -- no @types/node here; tsc would flag `require` as TS2580
const assert = require("node:assert");
assert.strictEqual(total, 29.97);
