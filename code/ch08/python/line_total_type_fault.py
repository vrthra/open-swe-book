# Chapter 8, §8.4.1 (type checkers) — a string price flows into arithmetic.
# python3 runs this file without complaint and prints a nonsense total.
# mypy rejects it before it runs (mypy 2.1.0):
#   line_total_type_fault.py:12: error: Argument 1 to "line_total" has
#   incompatible type "str"; expected "float"  [arg-type]

def line_total(price: float, quantity: int) -> float:
  return price * quantity


price = "9.99"              # read from a CSV row, still a string
total = line_total(price, 3)
print(total)                # no crash: prints 9.999.999.99

# str * int repeats the string — silently wrong, no exception raised.
assert total == "9.999.999.99"
