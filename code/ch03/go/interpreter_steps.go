// Section 3.4.1 (Given / When / Then) — godog-style step definitions that make the
// chapter's interpreter-alert scenarios executable. In a godog project the steps are
// registered in InitializeScenario(sc *godog.ScenarioContext) and run under go test.
// Here a stand-in ScenarioContext and a tiny runner feed the steps the .feature
// text, so the file runs standalone with go run.
package main

import (
	"fmt"
	"os"
	"regexp"
	"slices"
	"strings"
)

const feature = `
Feature: Interpreter alerts
  So that clinicians are prepared, staff want a visible interpreter flag.

  Scenario: Patient needs an interpreter
    Given a checked-in patient flagged for an interpreter
    When the clinician opens the visit
    Then an "interpreter needed" banner is shown

  Scenario: Patient does not need an interpreter
    Given a checked-in patient with no interpreter flag
    When the clinician opens the visit
    Then no interpreter banner is shown
`

// --- clinic scheduling app code under test ------------------------------------

type Patient struct{ checkedIn, interpreter bool }

type Visit struct{ banners []string }

func checkIn(interpreter bool) Patient {
	return Patient{checkedIn: true, interpreter: interpreter}
}

func openVisit(p Patient) Visit {
	if p.interpreter {
		return Visit{banners: []string{"interpreter needed"}}
	}
	return Visit{}
}

// --- stand-in for godog.ScenarioContext ----------------------------------------

type step struct {
	re *regexp.Regexp
	fn any // godog accepts func() or func() error, among others
}

type ScenarioContext struct{ steps []step }

func (sc *ScenarioContext) add(expr string, fn any) {
	sc.steps = append(sc.steps, step{regexp.MustCompile(expr), fn})
}

func (sc *ScenarioContext) Given(expr string, fn any) { sc.add(expr, fn) }
func (sc *ScenarioContext) When(expr string, fn any)  { sc.add(expr, fn) }
func (sc *ScenarioContext) Then(expr string, fn any)  { sc.add(expr, fn) }

func (sc *ScenarioContext) run(text string) error {
	for _, s := range sc.steps {
		if !s.re.MatchString(text) {
			continue
		}
		if fn, ok := s.fn.(func() error); ok {
			return fn()
		}
		s.fn.(func())()
		return nil
	}
	return fmt.Errorf("no step matches %q", text)
}

// --- step definitions (as printed in the book; there sc *godog.ScenarioContext) --

var patient Patient
var visit Visit

func flagged()    { patient = checkIn(true) }
func notFlagged() { patient = checkIn(false) }
func opens()      { visit = openVisit(patient) }

func bannerShown() error { return wantBanners("interpreter needed") }
func noBanner() error    { return wantBanners() }

func wantBanners(exp ...string) error {
	if slices.Equal(visit.banners, exp) {
		return nil
	}
	return fmt.Errorf("banners = %v, want %v", visit.banners, exp)
}

func InitializeScenario(sc *ScenarioContext) {
	sc.Given(`^a checked-in patient flagged for an interpreter$`, flagged)
	sc.Given(`^a checked-in patient with no interpreter flag$`, notFlagged)
	sc.When(`^the clinician opens the visit$`, opens)
	sc.Then(`^an "interpreter needed" banner is shown$`, bannerShown)
	sc.Then(`^no interpreter banner is shown$`, noBanner)
}

// --- tiny runner: the .feature text drives the assertions -----------------------

func main() {
	sc := &ScenarioContext{}
	InitializeScenario(sc)
	passed, inScenario := 0, false
	for _, raw := range strings.Split(feature, "\n") {
		line := strings.TrimSpace(raw)
		switch {
		case strings.HasPrefix(line, "Scenario:"):
			fmt.Println(line)
			patient, visit = Patient{}, Visit{}
			inScenario = true
			passed++
		case inScenario && line != "":
			_, text, _ := strings.Cut(line, " ") // godog matches the text after the keyword
			if err := sc.run(text); err != nil {
				fmt.Println("    " + line + " ... FAIL: " + err.Error())
				os.Exit(1)
			}
			fmt.Println("    " + line + " ... ok")
		}
	}
	fmt.Printf("%d scenarios passed\n", passed)
}
