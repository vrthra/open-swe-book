# §9.1.4 Test Oracles — property oracle for median(xs), as a property-based
# test. Uses PropCheck when installed (gem install prop_check); otherwise
# falls back to a hand-rolled random-input loop over the same two properties.

def median(xs)
  xs.sort[xs.length / 2]                     # middle element (upper median)
end

def properties_hold(xs)
  m = median(xs)
  raise "order dependence on #{xs}" unless m == median(xs.reverse)
  raise "median #{m} not in inputs" unless xs.include?(m)
end

begin
  require "prop_check"
  g = PropCheck::Generators
  PropCheck.forall(g.array(g.integer, empty: false)) { |xs| properties_hold(xs) }
  puts "PropCheck: both properties held on generated lists"
rescue LoadError
  srand(9)
  10_000.times do
    xs = Array.new(rand(1..50)) { rand(-1000..1000) }
    properties_hold(xs)
  end
  puts "10000 random lists: both properties held"
end
