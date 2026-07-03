# §9.1.4 Test Oracles — property oracle for median(xs), as a property-based
# test. Uses Hypothesis when installed (pip install hypothesis); otherwise
# falls back to a hand-rolled random-input loop over the same two properties.


def median(xs):
  return sorted(xs)[len(xs) // 2]          # middle element (upper median)


def properties_hold(xs):
  m = median(xs)
  assert m == median(list(reversed(xs)))   # order independence
  assert m in xs                           # the median is one of the inputs


try:
  from hypothesis import given, strategies as st

  @given(st.lists(st.integers(), min_size=1))
  def test_median_properties(xs):
    properties_hold(xs)

  if __name__ == "__main__":
    test_median_properties()
    print("Hypothesis: both properties held on generated lists")

except ModuleNotFoundError:
  import random

  if __name__ == "__main__":
    random.seed(9)
    for _ in range(10_000):
      xs = [random.randint(-1000, 1000) for _ in range(random.randint(1, 50))]
      properties_hold(xs)
    print("10000 random lists: both properties held")
