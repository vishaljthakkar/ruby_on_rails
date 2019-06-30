puts "### Ranges"

my_range = 1..3
puts my_range.max
puts my_range.include?(2)

puts (1..10) === 5.3
puts ('a'...'r') === "r"

p ('a'..'r').to_a.sample(2)

age = 55
case age
when 0..12 then puts "Still a baby"
when 13..99 then puts "Teenager at heart"
else puts "You are getting older. . ."
end
