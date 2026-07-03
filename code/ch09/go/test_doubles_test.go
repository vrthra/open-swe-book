// §9.2.1 Unit Testing — the three test doubles (stub, mock, fake) standing in
// for the discounts dependency of PriceService (defined in price_service.go).

package discount

import (
	"slices"
	"testing"
)

// --- stub: canned answers, nothing more ---

type StubCatalog struct{}

func (StubCatalog) PriceOf(item string) float64 { return 12.0 } // every item costs 12.0

type StubDiscounts struct{}

func (StubDiscounts) PercentFor(item string) float64 { return 25 } // canned answer

func TestStubFeedsCannedPercent(t *testing.T) {
	svc := NewPriceService(StubCatalog{}, StubDiscounts{})
	if got, err := svc.Quote("mug"); err != nil || got != 9.0 {
		t.Errorf("got %v, %v; want 9.0", got, err) // 12.0 * (1 - 0.25)
	}
}

// --- mock: records the interaction so the test can assert on it ---

type MockDiscounts struct{ calls []string }

func (m *MockDiscounts) PercentFor(item string) float64 {
	m.calls = append(m.calls, item)
	return 25
}

func TestMockRecordsInteraction(t *testing.T) {
	mock := &MockDiscounts{}
	NewPriceService(StubCatalog{}, mock).Quote("mug")
	if !slices.Equal(mock.calls, []string{"mug"}) { // called exactly once, with "mug"
		t.Errorf("calls = %v; want [mug]", mock.calls)
	}
}

// --- fake: a lightweight working implementation ---

// FakeDiscounts reads an in-memory table; a missing item means no discount (0).
type FakeDiscounts struct{ table map[string]float64 }

func (f FakeDiscounts) PercentFor(item string) float64 { return f.table[item] }

func TestFakeBehavesLikeRealTable(t *testing.T) {
	svc := NewPriceService(StubCatalog{}, FakeDiscounts{map[string]float64{"mug": 25}})
	if got, _ := svc.Quote("mug"); got != 9.0 {
		t.Errorf("mug: got %v; want 9.0", got)
	}
	if got, _ := svc.Quote("bowl"); got != 12.0 { // unknown item: no discount
		t.Errorf("bowl: got %v; want 12.0", got)
	}
}
