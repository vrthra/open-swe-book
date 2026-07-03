// §9.2.2 — integration test wiring the real (map-backed) components together.
package discount

import "testing"

func TestQuoteIntegratesCatalogAndDiscounts(t *testing.T) {
	catalog := MapCatalog{"mug": 12.0}
	discounts := MapDiscounts{"mug": 25}
	svc := PriceService{catalog, discounts}
	got, err := svc.Quote("mug")
	if err != nil || got != 9.0 { // 12.0 * (1 - 0.25)
		t.Errorf("got %v, %v; want 9.0", got, err)
	}
}
