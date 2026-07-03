// §9.3.1 — the control-flow-graph worked example: classify a number and,
// for non-negative numbers, sum 1..n. Node comments match the CFG figure.
public class ClassifyAndSum {
  static String classifyAndSum(int n) {  // node 1  (entry)
    if (n < 0) {                         // node 2  (decision)
      return "negative";                 // node 3
    }
    int total = 0;                       // node 4
    int i = 1;                           // node 4
    while (i <= n) {                     // node 5  (decision)
      total += i;                        // node 6
      i += 1;                            // node 6
    }
    return "sum=" + total;               // node 7  (exit)
  }

  public static void main(String[] args) {
    assert classifyAndSum(-5).equals("negative") : "T1: node 2 true edge";
    assert classifyAndSum(3).equals("sum=6") : "T2: loop runs three times";
    assert classifyAndSum(0).equals("sum=0") : "loop body never executes";
    System.out.println("classifyAndSum: statement/branch example ok");
  }
}
