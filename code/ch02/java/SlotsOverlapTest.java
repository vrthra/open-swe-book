// Chapter 2, §2.3.2 "Testing: Make It Central to Development" — one red–green
// TDD micro-cycle for the clinic-scheduling app's appointment-slot overlap check,
// JUnit 5 variant.
// Red: with the slotsOverlap method below removed, compilation fails with
// "cannot find symbol: method slotsOverlap" (Java's red is a compile error).
// Green: with it in place, both tests pass. Run with the JUnit console launcher:
//   javac -cp junit-platform-console-standalone.jar SlotsOverlapTest.java
//   java -jar junit-platform-console-standalone.jar execute --class-path . \
//     --scan-class-path
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class SlotsOverlapTest {
  static boolean slotsOverlap(String aStart, String aEnd, String bStart, String bEnd) {
    return aStart.compareTo(bEnd) < 0 && bStart.compareTo(aEnd) < 0;
  }

  @Test void overlappingSlotsConflict() {
    assertTrue(slotsOverlap("09:00", "09:30", "09:15", "09:45"));
  }

  @Test void backToBackSlotsDoNotConflict() {
    assertFalse(slotsOverlap("09:00", "09:30", "09:30", "10:00"));
  }
}
