// Chapter 5, §5.3.1 — the failure postcondition of "Withdraw Cash from ATM" as a test:
// no money out without a matching debit, even when the authorization link drops (B1).
public class FailureGuarantee {
  static class LostLinkBank {               // the fake — the link drops at step 8
    java.util.List<Integer> debits = new java.util.ArrayList<>();
    void authorize(int amount) { throw new IllegalStateException("link lost"); }
  }
  static class Atm {
    int dispensed = 0;
    void dispense(int amount) { dispensed += amount; }
  }
  static void withdraw(Atm atm, LostLinkBank bank, int amount) {  // steps 8–11
    try { bank.authorize(amount); }
    catch (IllegalStateException e) { return; }  // B1 — cancel, return the card
    atm.dispense(amount);
    bank.debits.add(amount);
  }
  public static void main(String[] args) {  // run with java -ea (assertions on)
    Atm atm = new Atm();
    LostLinkBank bank = new LostLinkBank();
    withdraw(atm, bank, 200);
    // the failure postcondition, verbatim
    assert atm.dispensed == 0 && bank.debits.isEmpty();
    System.out.println("failure guarantee holds: no cash dispensed, no debit recorded");
  }
}
