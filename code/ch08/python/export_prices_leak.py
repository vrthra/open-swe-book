# Chapter 8, §8.4.1 (data-flow analyzers) — a resource leaked on one path.
# The file is opened near the top of export_prices and closed at the bottom,
# but the error-path `return` in between skips the close. pylint flags the
# acquisition (pylint 4.0.6):
#   export_prices_leak.py:10:10: R1732: Consider using 'with' for
#   resource-allocating operations (consider-using-with)
# The checks below prove the leak at runtime via CPython's ResourceWarning.

def export_prices(catalog, discounts, path):
  out = open(path, "w")
  out.write("item,price\n")
  for item, price in sorted(catalog.items()):
    pct = discounts.percent_for(item)
    if pct < 0 or pct > 100:
      return None                 # error path: `out` is never closed
    final = round(price * (1 - pct / 100), 2)
    out.write(f"{item},{final}\n")
  out.close()
  return path


class FakeDiscounts:                    # same stand-in as Chapter 9, §9.3
  def __init__(self, table):
    self.table = dict(table)

  def percent_for(self, item):
    return self.table.get(item, 0)


import gc
import os
import tempfile
import warnings

path = os.path.join(tempfile.mkdtemp(), "prices.csv")

# Normal path: file written and closed.
assert export_prices({"mug": 10.0, "bowl": 12.0},
          FakeDiscounts({"mug": 25}), path) == path
with open(path) as f:
  assert f.read() == "item,price\nbowl,12.0\nmug,7.5\n"

# Error path: a 120% discount triggers the early return and leaks the handle.
with warnings.catch_warnings(record=True) as caught:
  warnings.simplefilter("always")
  assert export_prices({"mug": 10.0}, FakeDiscounts({"mug": 120}), path) is None
  gc.collect()
assert any(issubclass(w.category, ResourceWarning) for w in caught), \
  "expected a ResourceWarning from the unclosed handle"
print("leak confirmed on the error path; normal path wrote the file")
