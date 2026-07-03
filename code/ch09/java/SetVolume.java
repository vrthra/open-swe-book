// §9.4.2 — the buggy boundary guard (`>=` where the spec demands `>`), plus a
// demonstration that the boundary test at 100 fails against it while the
// equivalence-class representatives all pass.
public class SetVolume {
  static int current = 0;

  static void apply(int level) { current = level; }

  static void setVolume(int level) {
    if (level < 1 || level >= 100)  // BUG: >= should be >
      throw new IllegalArgumentException("level must be 1..100");
    apply(level);
  }

  static boolean rejected(int level) {
    try { setVolume(level); return false; }
    catch (IllegalArgumentException e) { return true; }
  }

  public static void main(String[] args) {
    assert !rejected(55);   // C2 representative: accepted — the bug hides
    assert rejected(-3);    // C1 representative: rejected
    assert rejected(250);   // C3 representative: rejected
    assert rejected(0);     // just below lower boundary: rejected
    assert !rejected(1) && !rejected(2) && !rejected(99);  // accepted values
    assert rejected(101);   // above upper boundary: rejected
    // The payoff: the spec says 100 is valid, but the buggy guard rejects it,
    // so the boundary test `set_volume(100)` FAILS — for exactly this reason.
    assert rejected(100) : "boundary test at 100 should expose the >= bug";
    System.out.println("boundary test setVolume(100) fails against the buggy guard");
  }
}
