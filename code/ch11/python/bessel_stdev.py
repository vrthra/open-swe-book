# §11.7.1 Variance from the Mean — sample vs. population standard deviation
# on the running customer-found-defect dataset. Confirms the hand computation
# in the chapter: s = 5.85 (divide by n - 1), sigma = 5.58 (divide by n).
import statistics

cfds = [2, 4, 5, 5, 7, 8, 9, 10, 12, 14, 23]

s = statistics.stdev(cfds)       # divides by n - 1 (Bessel's correction)
sigma = statistics.pstdev(cfds)  # divides by n

print(f"s     = {s:.2f}")      # 5.85 — matches the hand computation
print(f"sigma = {sigma:.2f}")  # 5.58

assert round(s, 2) == 5.85
assert round(sigma, 2) == 5.58
# NumPy's np.std() defaults to ddof=0 — the population version — with no
# warning. Pass ddof=1 when your data are a sample.
