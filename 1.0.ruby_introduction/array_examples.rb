puts "### Arrays"

het_arr = [1, "two", :three]  # heterogenous type
puts het_arr[1]

arr_words = %w{ what a great day today! }
puts arr_words
puts arr_words[-2]

puts "#{arr_words.first} - #{arr_words.last}"

#Range type
p arr_words[2..4]

puts arr_words.join(',')


puts "### Modifying an Array"

het_arr << "test"

p het_arr


puts "### Array methods"

my_arr = [rand(10), rand(10), rand(10), rand(10), rand(10)]

p my_arr
p my_arr.sample
p my_arr.sort!
p my_arr.reverse!

puts "### Stack and Queues using Array"

stack = []; stack << "one"; stack.push("two")
p stack
puts stack.pop
p stack

queue = []; queue.push "one"; queue.push "two"
p queue
puts queue.shift
p queue

a = [5,4,3,2].sort!.reverse!
p a
p = a.sample(2)

a[6] = 33

p a


# each: iterator over an array that takes a block
# select: filtering and also takes a block
# reject: filter array by rejecting
# map: modify each element of an array and return new array
#
#
my_arr = [1, 3, 4, 7, 8, 10]
puts "### Array Processing"
my_arr.each { |num| print num }
puts # print new line

new_arr = my_arr.select {|num| num > 4}
p new_arr

new_arr = my_arr.select {|num| num < 10}
                .reject{|num| num.even?}
p new_arr

# Multiply each element by 3 producing new array
new_arr = my_arr.map {|num| num * 3 }
p new_arr


