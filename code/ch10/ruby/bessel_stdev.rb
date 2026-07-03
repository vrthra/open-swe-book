# §10.7.1 Variance from the Mean — sample vs. population standard deviation
# on the running customer-found-defect dataset. Confirms the hand computation
# in the chapter: s = 5.85 (divide by n - 1), sigma = 5.58 (divide by n).
cfds = [2, 4, 5, 5, 7, 8, 9, 10, 12, 14, 23]

mean = cfds.sum.to_f / cfds.length
ss = cfds.sum { |x| (x - mean)**2 }

s = Math.sqrt(ss / (cfds.length - 1)) # divides by n - 1 (Bessel's correction)
sigma = Math.sqrt(ss / cfds.length)   # divides by n

puts format('s     = %.2f', s)      # 5.85 — matches the hand computation
puts format('sigma = %.2f', sigma)  # 5.58

raise 'unexpected s' unless s.round(2) == 5.85
raise 'unexpected sigma' unless sigma.round(2) == 5.58
