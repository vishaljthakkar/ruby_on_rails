def simple
  puts "no parens"
end

def simple1()
  puts "yes parens"
end

simple
simple()
simple1

puts "### Return ###"
def add(one, two)
  one + two # last line is returned no explicit return required
end

def divide(one, two)
  return "I dont think so" if two == 0
  one / two
end

puts add(2, 2)
puts divide(2, 0)
puts divide(12, 4)

puts "### Expressive Method Names"
def can_divide_by?(number)
  return false if number.zero?
  true
end

puts can_divide_by? 3
puts can_divide_by? 0

puts "### Default Arguments"

def factorial(n)
  n == 0? 1 : n * factorial(n - 1)
end

def factorial_with_default(n = 5)
  n == 0? 1 : n * factorial_with_default( n - 1)
end

puts factorial 5
puts factorial_with_default
puts factorial_with_default 3

puts "### Splat"

def my_max(one_param, *numbers, another)
  # Variable length parameters passed in
  # become an array
  numbers.max
end

puts my_max("something", 7, 32, -1, "more")
