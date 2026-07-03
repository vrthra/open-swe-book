// Section 3.4.1 (Given / When / Then) — cucumber-js step definitions that make the
// chapter's interpreter-alert scenarios executable. In a cucumber-js project the
// definitions below live in features/step_definitions/ and begin with
//     const { Given, When, Then } = require("@cucumber/cucumber");
// Here a minimal stand-in registers the steps and a tiny runner feeds them the
// .feature text, so the file runs standalone with node.

const assert = require("node:assert");

const FEATURE = `\
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
`;

// --- clinic scheduling app code under test ------------------------------------

function checkIn({ interpreter }) {
  return { checkedIn: true, interpreter };
}

function openVisit(patient) {
  return { banners: patient.interpreter ? ["interpreter needed"] : [] };
}

// --- stand-in for cucumber-js's Given / When / Then ----------------------------

const steps = new Map();
const stepFor = (keyword) => (text, fn) => steps.set(`${keyword} ${text}`, fn);
const Given = stepFor("Given");
const When = stepFor("When");
const Then = stepFor("Then");

// --- step definitions (as printed in the book) ---------------------------------

Given("a checked-in patient flagged for an interpreter", function () {
  this.patient = checkIn({ interpreter: true });
});

Given("a checked-in patient with no interpreter flag", function () {
  this.patient = checkIn({ interpreter: false });
});

When("the clinician opens the visit", function () {
  this.visit = openVisit(this.patient);
});

Then('an "interpreter needed" banner is shown', function () {
  assert.ok(this.visit.banners.includes("interpreter needed"));
});

Then("no interpreter banner is shown", function () {
  assert.equal(this.visit.banners.length, 0);
});

// --- tiny runner: the .feature text drives the assertions -----------------------

function run(featureText) {
  let passed = 0;
  let world = null; // cucumber-js binds `this` in each step to a fresh World
  for (const raw of featureText.split("\n")) {
    const line = raw.trim();
    if (line.startsWith("Scenario:")) {
      console.log(line);
      world = {};
      passed += 1;
    } else if (world !== null && line) {
      steps.get(line).call(world); // AssertionError = failing scenario
      console.log("    " + line + " ... ok");
    }
  }
  console.log(`${passed} scenarios passed`);
}

run(FEATURE);
