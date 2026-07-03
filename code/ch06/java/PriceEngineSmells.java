// Chapter 6, exercises.md exercise 6 — PriceEngine listing exhibiting coupling smells
// (content, common, and control coupling) for students to critique. The smells are
// deliberate; do not imitate this design.
// Run: java PriceEngineSmells.java
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

class Globals { static double lastTotal = 0.0; }  // read by Checkout and Receipt

class Item { int qty; double retail, wholesale; }
class Cart { List<Item> items = new ArrayList<>(); }  // internals, not an interface

class PriceEngine {
  void compute(Cart cart, boolean isB2b) {
    cart.items.sort(Comparator.comparingInt(i -> i.qty));  // sorts another object's data
    double total = 0.0;
    for (Item item : cart.items) {
      if (isB2b) {
        total += item.wholesale * item.qty * 0.9;
      } else {
        total += item.retail * item.qty;
      }
    }
    Globals.lastTotal = total;
  }
}

class Receipt {
  String render() { return String.format("Total: $%.2f", Globals.lastTotal); }
}

// Demonstration that the listing runs (students critique the design above).
public class PriceEngineSmells {
  static Item item(int qty, double retail, double wholesale) {
    Item i = new Item();
    i.qty = qty; i.retail = retail; i.wholesale = wholesale;
    return i;
  }

  public static void main(String[] args) {
    Cart cart = new Cart();
    cart.items.add(item(2, 5.00, 4.00));
    cart.items.add(item(1, 12.50, 10.00));

    new PriceEngine().compute(cart, false);
    if (Globals.lastTotal != 22.50) throw new AssertionError();
    if (!new Receipt().render().equals("Total: $22.50")) throw new AssertionError();

    new PriceEngine().compute(cart, true);
    if (Math.abs(Globals.lastTotal - 16.20) > 1e-9)  // (2*4.00 + 1*10.00) * 0.9
      throw new AssertionError();
    System.out.println("retail total 22.50, b2b total 16.20: OK");
  }
}
