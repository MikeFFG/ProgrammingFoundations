def factors(number)
  dividend = number
  divisors = []
  while dividend > 0 do
    divisors << number / dividend if number % dividend == 0 # make sure there is no remainder...means its a factor
    dividend -= 1
  end
  divisors #return divisors for use in program.
end

p factors(-1)