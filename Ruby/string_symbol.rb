puts "### String Single Quote, Double Quote and String interpolation"

single_quoted = 'ice cream \n followed by it\'s party!'
double_quoted = "ice cream \n followed by it\'s party!"

puts single_quoted
puts double_quoted


def multiply(one, two)
  "#{one} multiplied by #{two} equals #{one * two}"
end

puts multiply(5, 2)


puts "### More Strings"

my_name = " john"
puts my_name.lstrip.capitalize # does not modify original string variable
p my_name
my_name.lstrip!.capitalize! # destructive. modifies original string variable
p my_name
my_name[0] = 'K'
p my_name

# Multi line string
cur_weather = %Q{ It's a hot day outside
                  Grab your umbrellas. . . }
puts cur_weather

cur_weather.lines do |line|
  line.sub! 'hot', 'rainy' # substitute word
  puts "#{line.strip}"
end

puts "### Symbols"
# Symbols are highly optimized string
# They are guaranteed to be unique and immutable.
# Can to converted to String with to_s and back using to_sym
# Example: Method names are symbols.
# irb(main):004:0> "hello".methods.grep /case/
# => [:casecmp, :casecmp?, :downcase, :upcase, :swapcase, :downcase!, :swapcase!, :upcase!]
# irb(main):005:0>


