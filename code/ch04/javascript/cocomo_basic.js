// §4.6.2 The Cocomo Family of Estimation Models — Basic COCOMO effort and
// schedule for the clinic scheduling app (organic mode: a = 2.4, b = 1.05).
const assert = require("node:assert");

const effort = (kloc, a = 2.4, b = 1.05) => a * kloc ** b; // Basic COCOMO, organic
const schedule = (e) => 2.5 * e ** 0.38;                   // calendar months

const row = (kloc, e) =>
  `${kloc} KLOC: ${e.toFixed(1).padStart(5)} person-months, ` +
  `${schedule(e).toFixed(1)} months`;

const [e20, e40] = [effort(20), effort(40)];
console.log(row(20, e20));
console.log(row(40, e40));
console.log(`doubling factor: ${(e40 / e20).toFixed(2)}`);

// Checks against the chapter text.
assert.strictEqual(Math.round(e20), 56);            // "~56 person-months"
assert.strictEqual(e40.toFixed(1), "115.4");        // "≈ 115.4 person-months"
assert.strictEqual((e40 / e20).toFixed(2), "2.07"); // "a factor of 2.07, not 2.0"
assert.ok(Math.abs(e40 / e20 - 2 ** 1.05) < 1e-9);  // penalty set by b alone
