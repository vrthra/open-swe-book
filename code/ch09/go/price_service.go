// §9.2.2 — PriceService wires the catalog and discount units together. The
// test doubles in test_doubles_test.go stand in for its dependencies (§9.2.1);
// the map-backed components below are the "real" ones the integration test
// (price_service_integration_test.go) wires together.
package discount

type Catalog interface{ PriceOf(item string) float64 }
type Discounts interface{ PercentFor(item string) float64 }

type PriceService struct {
	catalog   Catalog   // unit A: name -> base price
	discounts Discounts // unit B: name -> percent off
}

func NewPriceService(catalog Catalog, discounts Discounts) PriceService {
	return PriceService{catalog, discounts}
}

func (s PriceService) Quote(item string) (float64, error) {
	base := s.catalog.PriceOf(item)
	pct := s.discounts.PercentFor(item)
	return ApplyDiscount(base, pct)
}

// MapCatalog and MapDiscounts are the real (map-backed) components.
type MapCatalog map[string]float64

func (c MapCatalog) PriceOf(item string) float64 { return c[item] }

type MapDiscounts map[string]float64

func (d MapDiscounts) PercentFor(item string) float64 { return d[item] }
