// §4.6.2 The Cocomo Family of Estimation Models — Basic COCOMO effort and
// schedule for the clinic scheduling app (organic mode: a = 2.4, b = 1.05).
public class CocomoBasic {
  static double effort(double kloc) {          // Basic COCOMO, organic
    return 2.4 * Math.pow(kloc, 1.05);
  }

  static double schedule(double e) {
    return 2.5 * Math.pow(e, 0.38);            // calendar months
  }

  public static void main(String[] args) {
    double e20 = effort(20), e40 = effort(40);
    System.out.printf("20 KLOC: %5.1f person-months, %.1f months%n", e20, schedule(e20));
    System.out.printf("40 KLOC: %5.1f person-months, %.1f months%n", e40, schedule(e40));
    System.out.printf("doubling factor: %.2f%n", e40 / e20);

    // Checks against the chapter text.
    assert Math.round(e20) == 56;                   // "~56 person-months"
    assert Math.round(e40 * 10) == 1154;            // "≈ 115.4 person-months"
    assert Math.round(e40 / e20 * 100) == 207;      // "a factor of 2.07, not 2.0"
    assert Math.abs(e40 / e20 - Math.pow(2, 1.05)) < 1e-9;  // penalty set by b alone
  }
}
