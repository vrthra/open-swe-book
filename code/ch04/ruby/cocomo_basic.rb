# §4.6.2 The Cocomo Family of Estimation Models — Basic COCOMO effort and
# schedule for the clinic scheduling app (organic mode: a = 2.4, b = 1.05).
def effort(kloc, a: 2.4, b: 1.05) # Basic COCOMO, organic
  a * kloc**b
end

def schedule(effort)
  2.5 * effort**0.38 # calendar months
end

e20, e40 = effort(20), effort(40)
puts format('20 KLOC: %5.1f person-months, %.1f months', e20, schedule(e20))
puts format('40 KLOC: %5.1f person-months, %.1f months', e40, schedule(e40))
puts format('doubling factor: %.2f', e40 / e20)

# Checks against the chapter text.
raise 'unexpected e20' unless e20.round == 56              # "~56 person-months"
raise 'unexpected e40' unless e40.round(1) == 115.4        # "≈ 115.4 person-months"
raise 'unexpected ratio' unless (e40 / e20).round(2) == 2.07
raise 'ratio should be 2**b' unless ((e40 / e20) - 2**1.05).abs < 1e-9
