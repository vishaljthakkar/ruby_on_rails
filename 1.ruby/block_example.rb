puts "### Blocks"

#
# * Enclosed between {} or the keywords 'do' and 'end'
# * Passed to methods as last paramenter.

1.times { puts "This is from single line block" }

2.times do |index|
  if index > 0
    puts "This is from multi-line block"
  end
end

2.times { |index| puts "Same as above but in single line" if index > 0}

puts "### Blocks within the method"

def two_times_implicit
  return "Implicit No block" unless block_given? #this is a built in method
  yield
  yield
  # yield
end

puts two_times_implicit { print "Implicit Hello "}
puts two_times_implicit

# Explicit block is more direct
def two_times_explicit(&i_am_a_block)
  return "Explicit No block" if i_am_a_block.nil?
  i_am_a_block.call
  i_am_a_block.call
end

puts two_times_explicit
puts two_times_explicit { print "Explicit Hello "}
