// Chapter 8, Exercises §9 — the apply_discount code-review exercise, runnable.
// Two defects are planted ON PURPOSE; do not "fix" this file:
//   1. `Math.max(total, 0)` discards its result, so the clamp is a no-op
//      (IntelliJ: "Result of 'Math.max()' is ignored").
//   2. `discounts.lookup(code)` can return null, and `.percent` then throws.
// The exercise asks students to review the function and to run a linter or
// static analyzer over it. The checks below demonstrate both defects.

import java.util.List;
import java.util.Map;

public class ApplyDiscountReview {
  static class Item {
    double price;
    int quantity;
    Item(double price, int quantity) { this.price = price; this.quantity = quantity; }
  }

  static class Discount {
    double percent;
    Discount(double percent) { this.percent = percent; }
  }

  static class Cart {
    List<Item> items;
    double total;
    Cart(List<Item> items) { this.items = items; }
  }

  static class Discounts {
    Map<String, Discount> table = Map.of("WELCOME10", new Discount(10),
        "BLOWOUT120", new Discount(120));
    Discount lookup(String code) { return table.get(code); }
  }

  static Discounts discounts = new Discounts();

  // Applies a discount code to a shopping cart and returns the new total.
  static double applyDiscount(Cart cart, String code) {
    double total = 0;
    for (Item item : cart.items) {
      total = total + item.price * item.quantity;
    }
    Discount discount = discounts.lookup(code);  // returns null if code is unknown
    total = total - total * discount.percent / 100;
    if (total < 0) {
      Math.max(total, 0);
    }
    cart.total = total;
    return total;
  }

  static Cart cart() { return new Cart(List.of(new Item(10.0, 2))); }

  public static void main(String[] args) {
    // The happy path works, which is how the defects survive casual testing.
    assert applyDiscount(cart(), "WELCOME10") == 18.0;

    // Defect 1: an over-100% discount produces a negative total; the "clamp"
    // statement discards Math.max's result, so the negative value escapes.
    assert applyDiscount(cart(), "BLOWOUT120") == -4.0;

    // Defect 2: an unknown code makes lookup return null, which is never checked.
    boolean threw = false;
    try {
      applyDiscount(cart(), "NOSUCH");
    } catch (NullPointerException e) {
      threw = true;
    }
    assert threw : "expected NullPointerException on unknown code";
    System.out.println("both planted defects demonstrated");
  }
}
