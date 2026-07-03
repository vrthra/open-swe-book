// Chapter 8, §8.4.1 (data-flow analyzers) — a resource leaked on one path.
// The writer is opened near the top of exportPrices and closed at the bottom,
// but the error-path `return` in between skips the close. SpotBugs 4.9.4:
//   M B OS: ExportPricesLeak.exportPrices(Map, ExportPricesLeak$Discounts,
//   String) may fail to close stream  At ExportPricesLeak.java:[line 23]
// The checks below prove the leak at runtime by counting open descriptors.

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;
import java.util.TreeMap;

public class ExportPricesLeak {
  record Discounts(Map<String, Integer> table) {  // same stand-in as Ch. 9, §9.3
    int percentFor(String item) { return table.getOrDefault(item, 0); }
  }

  static String exportPrices(Map<String, Double> catalog, Discounts discounts,
      String path) throws IOException {
    Writer out = new FileWriter(path);
    out.write("item,price\n");
    for (String item : new TreeMap<>(catalog).keySet()) {
      int pct = discounts.percentFor(item);
      if (pct < 0 || pct > 100) {
        return null;                // error path: `out` is never closed
      }
      double net = Math.round(catalog.get(item) * (1 - pct / 100.0) * 100) / 100.0;
      out.write(item + "," + net + "\n");
    }
    out.close();
    return path;
  }

  static long openDescriptors() throws IOException {
    try (var fds = Files.list(Path.of("/proc/self/fd"))) {  // Linux-only census
      return fds.count();
    }
  }

  public static void main(String[] args) throws IOException {
    Path path = Files.createTempDirectory("ch08").resolve("prices.csv");

    // Normal path: file written and closed.
    var catalog = Map.of("mug", 10.0, "bowl", 12.0);
    var ok = exportPrices(catalog, new Discounts(Map.of("mug", 25)), path.toString());
    assert path.toString().equals(ok);
    assert Files.readString(path).equals("item,price\nbowl,12.0\nmug,7.5\n");

    // Error path: a 120% discount triggers the early return and leaks the handle.
    long before = openDescriptors();
    var err = exportPrices(Map.of("mug", 10.0), new Discounts(Map.of("mug", 120)),
        path.toString());
    assert err == null;
    long after = openDescriptors();
    assert after == before + 1 : "expected one leaked descriptor, got " + (after - before);
    System.out.println("leak confirmed on the error path; normal path wrote the file");
  }
}
