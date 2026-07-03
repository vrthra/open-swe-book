// Chapter 8, §8.4.1 (type checkers) — a string price flows into arithmetic.
// javac rejects this file; it never runs (javac 26.0.1):
//   LineTotal.java:13: error: method lineTotal in class LineTotal cannot be
//   applied to given types; reason: argument mismatch; String cannot be
//   converted to double
public class LineTotal {
  static double lineTotal(double price, int quantity) {
    return price * quantity;
  }

  public static void main(String[] args) {
    String price = "9.99";  // read from a CSV row, still a string
    double total = lineTotal(price, 3);
    System.out.println(total);  // never runs: javac rejects the call
  }
}
