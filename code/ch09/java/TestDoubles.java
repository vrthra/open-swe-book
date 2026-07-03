// §9.2.1 Unit Testing — the three test doubles (stub, mock, fake) standing in
// for the discounts dependency of PriceService (§9.2.2, included here so the
// file runs standalone), as a JUnit 5 suite.
import static org.junit.jupiter.api.Assertions.*;
import java.util.*;
import org.junit.jupiter.api.Test;

interface Catalog { double priceOf(String item); }
interface Discounts { int percentFor(String item); }

class PriceService {
  final Catalog catalog;      // unit A: name -> base price
  final Discounts discounts;  // unit B: name -> percent off
  PriceService(Catalog catalog, Discounts discounts) {
    this.catalog = catalog;
    this.discounts = discounts;
  }
  double quote(String item) {
    return applyDiscount(catalog.priceOf(item), discounts.percentFor(item));
  }
  /** Reduce price by percent (0..100). Throws IllegalArgumentException on bad input. */
  static double applyDiscount(double price, double percent) {
    if (price < 0) throw new IllegalArgumentException("price must be non-negative");
    if (percent < 0 || percent > 100)
      throw new IllegalArgumentException("percent must be in 0..100");
    return Math.round(price * (1 - percent / 100) * 100) / 100.0;
  }
}

// --- stub: canned answers, nothing more ---
class StubCatalog implements Catalog {
  public double priceOf(String item) { return 12.0; }  // every item costs 12.0
}

class StubDiscounts implements Discounts {
  public int percentFor(String item) { return 25; }    // canned answer, whatever the item
}

// --- mock: records the interaction so the test can assert on it ---
class MockDiscounts implements Discounts {
  final List<String> calls = new ArrayList<>();
  public int percentFor(String item) {
    calls.add(item);
    return 25;
  }
}

// --- fake: a lightweight working implementation ---
class FakeDiscounts implements Discounts {
  final Map<String, Integer> table;              // in-memory stand-in
  FakeDiscounts(Map<String, Integer> table) { this.table = new HashMap<>(table); }
  public int percentFor(String item) { return table.getOrDefault(item, 0); }
}

class TestDoubles {
  @Test void stubFeedsCannedPercent() {
    var svc = new PriceService(new StubCatalog(), new StubDiscounts());
    assertEquals(9.0, svc.quote("mug"));         // 12.0 * (1 - 0.25)
  }

  @Test void mockRecordsInteraction() {
    var mock = new MockDiscounts();
    new PriceService(new StubCatalog(), mock).quote("mug");
    assertEquals(List.of("mug"), mock.calls);    // called exactly once, with "mug"
  }

  @Test void fakeBehavesLikeRealTable() {
    var svc = new PriceService(new StubCatalog(), new FakeDiscounts(Map.of("mug", 25)));
    assertEquals(9.0, svc.quote("mug"));
    assertEquals(12.0, svc.quote("bowl"));       // unknown item: no discount
  }
}
