// Section 3.4.1 (Given / When / Then) — Cucumber-JVM step definitions that make the
// chapter's interpreter-alert scenarios executable. In a Cucumber-JVM project the
// annotations below come from io.cucumber.java.en.* and the class lives under
// src/test/java. Here local stand-in annotations and a tiny reflection runner feed
// the steps the .feature text, so the file runs standalone:
//     java -ea InterpreterSteps.java

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.reflect.Method;
import java.util.List;

@Retention(RetentionPolicy.RUNTIME) @interface Given { String value(); }
@Retention(RetentionPolicy.RUNTIME) @interface When { String value(); }
@Retention(RetentionPolicy.RUNTIME) @interface Then { String value(); }

// --- clinic scheduling app code under test -------------------------------------
record Patient(boolean checkedIn, boolean interpreter) {}
record Visit(List<String> banners) {}

public class InterpreterSteps {
  static Patient checkIn(boolean interpreter) { return new Patient(true, interpreter); }

  static Visit openVisit(Patient p) {
    return new Visit(p.interpreter() ? List.of("interpreter needed") : List.of());
  }

  Patient patient;
  Visit visit;

  // --- step definitions (as printed in the book) -------------------------------
  @Given("a checked-in patient flagged for an interpreter")
  public void flagged() { patient = checkIn(true); }

  @Given("a checked-in patient with no interpreter flag")
  public void notFlagged() { patient = checkIn(false); }

  @When("the clinician opens the visit")
  public void opens() { visit = openVisit(patient); }

  @Then("an \"interpreter needed\" banner is shown")
  public void bannerShown() { assert visit.banners().contains("interpreter needed"); }

  @Then("no interpreter banner is shown")
  public void noBanner() { assert visit.banners().isEmpty(); }

  // --- tiny runner: the .feature text drives the assertions --------------------
  static final String FEATURE = """
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
      """;

  public static void main(String[] args) throws Exception {
    InterpreterSteps steps = null;
    int passed = 0;
    for (String raw : FEATURE.lines().toList()) {
      String line = raw.strip();
      if (line.startsWith("Scenario:")) {
        System.out.println(line);
        steps = new InterpreterSteps();
        passed++;
      } else if (steps != null && !line.isEmpty()) {
        int sp = line.indexOf(' ');
        find(line.substring(0, sp), line.substring(sp + 1)).invoke(steps);
        System.out.println("    " + line + " ... ok");
      }
    }
    System.out.println(passed + " scenarios passed");
  }

  static Method find(String keyword, String text) {
    for (Method m : InterpreterSteps.class.getDeclaredMethods()) {
      if (text.equals(stepText(m, keyword))) return m;
    }
    throw new IllegalStateException("no step matches: " + keyword + " " + text);
  }

  static String stepText(Method m, String keyword) {
    Given g = m.getAnnotation(Given.class);
    When w = m.getAnnotation(When.class);
    Then t = m.getAnnotation(Then.class);
    return switch (keyword) {
      case "Given" -> g == null ? null : g.value();
      case "When" -> w == null ? null : w.value();
      default -> t == null ? null : t.value();
    };
  }
}
