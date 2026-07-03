// §9.1.4 Test Oracles — property oracle for median(xs). The book shows this as
// a jqwik @Property test (verified against jqwik 1.9.3); jqwik needs the JUnit
// platform on the classpath, so this standalone twin checks the same two
// properties over 10,000 random lists with the standard library only.
//   java -ea MedianProperties.java
import java.util.*;

public class MedianProperties {
  static int median(List<Integer> xs) {
    var ys = new ArrayList<>(xs);
    Collections.sort(ys);
    return ys.get(ys.size() / 2);                // middle element (upper median)
  }

  static void propertiesHold(List<Integer> xs) {
    int m = median(xs);
    var rev = new ArrayList<>(xs);
    Collections.reverse(rev);
    assert m == median(rev) : "order dependence on " + xs;   // order independence
    assert xs.contains(m) : m + " not in " + xs;   // the median is one of the inputs
  }

  public static void main(String[] args) {
    var rnd = new Random(9);
    for (int i = 0; i < 10_000; i++) {
      var xs = new ArrayList<Integer>();
      for (int n = 1 + rnd.nextInt(50); n > 0; n--) xs.add(rnd.nextInt(2001) - 1000);
      propertiesHold(xs);
    }
    System.out.println("10000 random lists: both properties held");
  }
}
