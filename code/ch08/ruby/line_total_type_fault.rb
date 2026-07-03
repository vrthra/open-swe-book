# Chapter 8, §8.4.1 (type checkers) — a string price flows into arithmetic.
# Sorbet's static checker rejects the call before it runs (srb 0.6.13323):
#   line_total_type_fault.rb:21: Expected `Float` but found `String("9.99")`
#   for argument `price` https://srb.help/7002
# typed: true

# Runner boilerplate (trimmed from the book fence): with sorbet-runtime
# installed, sigs are ALSO enforced at runtime and would raise TypeError at
# the call below, so that handler is silenced to show what untyped Ruby does.
# Without the gem (e.g. in CI) the demonstration is identical — the sig is a
# static-checker annotation, and plain Ruby never sees it.
begin
  require "sorbet-runtime"
  T::Configuration.call_validation_error_handler = ->(signature, opts) {}
  extend T::Sig
  sig { params(price: Float, quantity: Integer).returns(Float) }
  def line_total(price, quantity) = price * quantity
rescue LoadError
  def line_total(price, quantity) = price * quantity
end

price = "9.99"              # read from a CSV row, still a string
total = line_total(price, 3)
puts total                  # untyped Ruby prints 9.999.999.99, no crash

# String#* repeats the string — silently wrong, no exception raised.
raise "expected 9.999.999.99" unless total == "9.999.999.99"
