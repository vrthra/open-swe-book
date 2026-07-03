// §9.2.2 — PriceService plus the integration test that wires the real
// (map-backed) Catalog and Discounts components together.
import static org.junit.jupiter.api.Assertions.*;
import java.util.Map;
import org.junit.jupiter.api.Test;

class Catalog {
  private final Map<String, Double> prices;         // name -> base price
  Catalog(Map<String, Double> prices) { this.prices = prices; }
  double priceOf(String item) { return prices.get(item); }
}

class Discounts {
  private final Map<String, Double> percents;       // name -> percent off
  Discounts(Map<String, Double> percents) { this.percents = percents; }
  double percentFor(String item) { return percents.getOrDefault(item, 0.0); }
}

class PriceService {
  private final Catalog catalog;      // unit A: name -> base price
  private final Discounts discounts;  // unit B: name -> percent off

  PriceService(Catalog catalog, Discounts discounts) {
    this.catalog = catalog;
    this.discounts = discounts;
  }

  double quote(String item) {
    double base = catalog.priceOf(item);
    double pct = discounts.percentFor(item);
    return applyDiscount(base, pct);
  }

  /** Reduce price by percent (0..100). Throws IllegalArgumentException on bad input. */
  static double applyDiscount(double price, double percent) {
    if (price < 0) throw new IllegalArgumentException("price must be non-negative");
    if (percent < 0 || percent > 100)
      throw new IllegalArgumentException("percent must be in 0..100");
    return Math.round(price * (1 - percent / 100) * 100) / 100.0;
  }
}

class PriceServiceIntegrationTest {
  @Test void quoteIntegratesCatalogAndDiscounts() {
    Catalog catalog = new Catalog(Map.of("mug", 12.0));
    Discounts discounts = new Discounts(Map.of("mug", 25.0));
    PriceService svc = new PriceService(catalog, discounts);
    assertEquals(9.0, svc.quote("mug"));  // 12.0 * (1 - 0.25)
  }
}
