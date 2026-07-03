// §11.2.7 Testing — the oracle problem: a generated unit test that passes with full
// coverage because it encodes the same misunderstanding as the generated code.
// Billing spec: discounted prices round half UP to the cent (5.125 -> 5.13).
// Run: java OracleProblem.java

import java.math.BigDecimal;
import java.math.RoundingMode;

public class OracleProblem {
  static double applyDiscount(double price, double percent) {
    return BigDecimal.valueOf(price * (1 - percent / 100))  // AI-generated: HALF_EVEN
        .setScale(2, RoundingMode.HALF_EVEN).doubleValue(); // = banker's rounding
  }

  static void testHalfOff() {  // AI-generated: asserts the code's own behavior
    if (applyDiscount(10.25, 50) != 5.12) throw new AssertionError();
  }

  public static void main(String[] args) {
    testHalfOff();  // passes — and every line of the unit is covered
    System.out.println(applyDiscount(10.25, 50)); // 5.12; the billing spec says 5.13
  }
}
