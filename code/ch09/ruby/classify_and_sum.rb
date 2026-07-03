# §9.3.1 — the control-flow-graph worked example: classify a number and,
# for non-negative numbers, sum 1..n. Node comments match the CFG figure.

def classify_and_sum(n)  # node 1  (entry)
  if n < 0               # node 2  (decision)
    return "negative"    # node 3
  end
  total = 0              # node 4
  i = 1                  # node 4
  while i <= n           # node 5  (decision)
    total += i           # node 6
    i += 1               # node 6
  end
  "sum=#{total}"         # node 7  (exit)
end

raise "T1 failed" unless classify_and_sum(-5) == "negative"  # node 2 true edge
raise "T2 failed" unless classify_and_sum(3) == "sum=6"      # loop runs 3 times
raise "n=0 failed" unless classify_and_sum(0) == "sum=0"     # loop never runs
puts "classify_and_sum: statement/branch example ok"
