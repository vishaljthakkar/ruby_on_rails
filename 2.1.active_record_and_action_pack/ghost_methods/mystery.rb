class Mystery

  # when a non existent method is called on a Class, Ruby searches the class and goes up the ancestor tree
  # if it cannot find the method in the class.
  # Eventually it calls method_missing and throws NoMethodError.
  # We can override method_missing as shown below where we can capture method, arguments to method and even block
  # that was passed when calling non existent method
  def method_missing(method_name, *args)
    puts "Looking for. . . . "
    puts "\"#{method_name}\" with parameters (#{args.join(', ')}) ?"
    puts "Sorry. . . he is on vacation. . ."
    yield "Ended up in missing method" if block_given?
  end
end

m = Mystery.new
m.solve_mystery("abc", 123123) do |answer|
  puts "And the answer is: #{answer}"
end
