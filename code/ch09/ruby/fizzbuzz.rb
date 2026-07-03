# Ch. 9 exercises — fizzbuzz, the subject of the draw-a-CFG exercise.

def fizzbuzz(n)
  if n % 15 == 0
    "FizzBuzz"
  elsif n % 3 == 0
    "Fizz"
  elsif n % 5 == 0
    "Buzz"
  else
    n.to_s
  end
end

raise unless fizzbuzz(15) == "FizzBuzz"
raise unless fizzbuzz(9) == "Fizz"
raise unless fizzbuzz(10) == "Buzz"
raise unless fizzbuzz(7) == "7"
puts "fizzbuzz exercise example ok"
