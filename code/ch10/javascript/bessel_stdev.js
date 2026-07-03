// §10.7.1 Variance from the Mean — sample vs. population standard deviation
// on the running customer-found-defect dataset. Confirms the hand computation
// in the chapter: s = 5.85 (divide by n - 1), sigma = 5.58 (divide by n).
const assert = require("node:assert");

const cfds = [2, 4, 5, 5, 7, 8, 9, 10, 12, 14, 23];

const mean = cfds.reduce((sum, x) => sum + x, 0) / cfds.length;
const ss = cfds.reduce((sum, x) => sum + (x - mean) ** 2, 0);

const s = Math.sqrt(ss / (cfds.length - 1)); // divides by n - 1 (Bessel's correction)
const sigma = Math.sqrt(ss / cfds.length);   // divides by n

console.log(`s     = ${s.toFixed(2)}`);     // 5.85 — matches the hand computation
console.log(`sigma = ${sigma.toFixed(2)}`); // 5.58

assert.strictEqual(s.toFixed(2), "5.85");
assert.strictEqual(sigma.toFixed(2), "5.58");
