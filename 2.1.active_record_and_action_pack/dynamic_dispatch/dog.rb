class Dog
  def bark
    puts "Woof, woof!"
  end

  def greet(greeting)
    puts greeting
  end
end

dog = Dog.new
dog.bark # regular dot notation
dog.send("bark")
dog.send(:bark)
method_name = :bark
dog.send method_name

dog.send(:greet, "Hello")

