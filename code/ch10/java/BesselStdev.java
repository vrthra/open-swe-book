// §10.7.1 Variance from the Mean — sample vs. population standard deviation
// on the running customer-found-defect dataset. Confirms the hand computation
// in the chapter: s = 5.85 (divide by n - 1), sigma = 5.58 (divide by n).
public class BesselStdev {
  public static void main(String[] args) {
    double[] cfds = {2, 4, 5, 5, 7, 8, 9, 10, 12, 14, 23};

    double mean = 0;
    for (double x : cfds) mean += x;
    mean /= cfds.length;
    double ss = 0;  // sum of squared deviations from the mean
    for (double x : cfds) ss += (x - mean) * (x - mean);

    double s = Math.sqrt(ss / (cfds.length - 1));  // divides by n - 1 (Bessel)
    double sigma = Math.sqrt(ss / cfds.length);    // divides by n

    System.out.printf("s     = %.2f%n", s);      // 5.85 — matches the hand computation
    System.out.printf("sigma = %.2f%n", sigma);  // 5.58

    assert Math.round(s * 100) == 585;
    assert Math.round(sigma * 100) == 558;
  }
}
