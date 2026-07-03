# Section 3.4.1 (Given / When / Then) — step definitions that make the chapter's
# interpreter-alert scenarios executable. In a behave project the step functions
# below live in features/steps/ and begin with
#     from behave import given, when, then
# Here a minimal stand-in registers the steps and a tiny runner feeds them the
# .feature text, so the file runs standalone with python3.

FEATURE = """\
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
"""

# --- clinic scheduling app code under test ------------------------------------


def check_in(interpreter):
  return {"checked_in": True, "interpreter": interpreter}


def open_visit(patient):
  return {"banners": ["interpreter needed"] if patient["interpreter"] else []}


# --- stand-in for behave's @given/@when/@then decorators -----------------------

_STEPS = {}


def _step(keyword):
  def for_text(text):
    def register(fn):
      _STEPS[(keyword, text)] = fn
      return fn
    return register
  return for_text


given, when, then = _step("Given"), _step("When"), _step("Then")


class Context:
  pass


# --- step definitions (as printed in the book) ---------------------------------

@given("a checked-in patient flagged for an interpreter")
def flagged(context):
  context.patient = check_in(interpreter=True)


@given("a checked-in patient with no interpreter flag")
def not_flagged(context):
  context.patient = check_in(interpreter=False)


@when("the clinician opens the visit")
def opens(context):
  context.visit = open_visit(context.patient)


@then('an "interpreter needed" banner is shown')
def banner_shown(context):
  assert "interpreter needed" in context.visit["banners"]


@then("no interpreter banner is shown")
def no_banner(context):
  assert not context.visit["banners"]


# --- tiny runner: the .feature text drives the assertions -----------------------


def run(feature_text):
  passed = 0
  context = None
  for raw in feature_text.splitlines():
    line = raw.strip()
    if line.startswith("Scenario:"):
      print(line)
      context = Context()
      passed += 1
    elif context is not None and line:
      keyword, _, text = line.partition(" ")
      _STEPS[(keyword, text)](context)  # AssertionError = failing scenario
      print("    " + line + " ... ok")
  print(f"{passed} scenarios passed")


if __name__ == "__main__":
  run(FEATURE)
