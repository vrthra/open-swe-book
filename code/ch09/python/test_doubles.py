# §9.2.1 Unit Testing — the three test doubles (stub, mock, fake) standing in
# for the `discounts` dependency of PriceService (defined in §9.2.2, included
# here so the file runs standalone with `python3 test_doubles.py`).


def apply_discount(price, percent):
  """Reduce price by percent (0..100). Raises ValueError on bad input."""
  if price < 0:
    raise ValueError("price must be non-negative")
  if percent < 0 or percent > 100:
    raise ValueError("percent must be in 0..100")
  return round(price * (1 - percent / 100), 2)


class PriceService:
  def __init__(self, catalog, discounts):
    self.catalog = catalog          # unit A: name -> base price
    self.discounts = discounts      # unit B: name -> percent off

  def quote(self, item):
    base = self.catalog.price_of(item)
    pct = self.discounts.percent_for(item)
    return apply_discount(base, pct)


# --- stub: canned answers, nothing more ---
class StubCatalog:
  def price_of(self, item): return 12.0        # every item costs 12.0

class StubDiscounts:
  def percent_for(self, item): return 25       # canned answer, whatever the item

svc = PriceService(StubCatalog(), StubDiscounts())
assert svc.quote("mug") == 9.0                   # 12.0 * (1 - 0.25)


# --- mock: records the interaction so the test can assert on it ---
class MockDiscounts:
  def __init__(self): self.calls = []
  def percent_for(self, item):
    self.calls.append(item)
    return 25

mock = MockDiscounts()
PriceService(StubCatalog(), mock).quote("mug")
assert mock.calls == ["mug"]                     # called exactly once, with "mug"


# --- fake: a lightweight working implementation ---
class FakeDiscounts:
  def __init__(self, table): self.table = dict(table)      # in-memory stand-in
  def percent_for(self, item): return self.table.get(item, 0)

svc = PriceService(StubCatalog(), FakeDiscounts({"mug": 25}))
assert svc.quote("mug") == 9.0
assert svc.quote("bowl") == 12.0                 # unknown item: no discount

print("stub, mock, and fake examples all passed")
