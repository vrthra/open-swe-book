// Chapter 8, §8.4.1 (data-flow analyzers) — a resource leaked on one path.
// The file handle is opened near the top of exportPrices and closed at the
// bottom, but the error-path `return` in between skips the close. Node itself
// reports the abandoned handle when the garbage collector finds it:
//   Warning: Closing file descriptor 20 on garbage collection
// The check below forces a collection to prove the leak at runtime.

const fs = require("node:fs/promises");
const assert = require("node:assert");
const os = require("node:os");
const path = require("node:path");
const v8 = require("node:v8");
const vm = require("node:vm");

async function exportPrices(catalog, discounts, path) {
  const out = await fs.open(path, "w");
  await out.write("item,price\n");
  for (const item of Object.keys(catalog).sort()) {
    const pct = discounts.percentFor(item);
    if (pct < 0 || pct > 100) {
      return null;                // error path: `out` is never closed
    }
    const final = Math.round(catalog[item] * (1 - pct / 100) * 100) / 100;
    await out.write(`${item},${final}\n`);
  }
  await out.close();
  return path;
}

class FakeDiscounts {                   // same stand-in as Chapter 9, §9.3
  constructor(table) { this.table = table; }
  percentFor(item) { return this.table[item] ?? 0; }
}

async function main() {
  const file = path.join(await fs.mkdtemp(path.join(os.tmpdir(), "ch08-")), "prices.csv");

  // Normal path: file written and closed.
  assert.equal(await exportPrices({ mug: 10.0, bowl: 12.0 },
    new FakeDiscounts({ mug: 25 }), file), file);
  assert.equal(await fs.readFile(file, "utf8"), "item,price\nbowl,12\nmug,7.5\n");

  // Error path: a 120% discount triggers the early return and leaks the handle.
  let warned = false;
  process.on("warning", (w) => {
    if (/Closing file descriptor \d+ on garbage collection/.test(w.message)) warned = true;
  });
  assert.equal(await exportPrices({ mug: 10.0 }, new FakeDiscounts({ mug: 120 }), file),
    null);
  v8.setFlagsFromString("--expose-gc");        // force a GC so the leak surfaces now
  vm.runInNewContext("gc")();
  await new Promise((resolve) => setTimeout(resolve, 50));
  assert.ok(warned, "expected Node's file-descriptor GC warning");
  console.log("leak confirmed on the error path; normal path wrote the file");
}

main();
