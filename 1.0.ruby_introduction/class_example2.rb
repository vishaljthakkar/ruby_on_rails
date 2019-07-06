# || operator evaluates the left side
# if true: returns it
# Else - returns the right side.
# @x = @x || 5 will return 5 the first time and @x the next time
# short form: @x ||= 5
#

class Person
  attr_reader   :age
  attr_accessor :name

  def initialize(name, age) #constructor
    @name = name
    self.age = age
  end

  def age= (new_age)
    @age = @age || 5 # 5 is default
    @age = new_age unless new_age > 120
  end
end

puts "### Classes - || operator"
person = Person.new("Kim", 130)
puts person.age
person.age = 10
puts person.age
person.age = 200
puts person.age

class MathFunctions
  def self.double(var)  # one way to define class level method
    times_called
    var * 2;
  end

  class << self         # second way to define class level method
    def times_called
      @@times_called ||= 0 # @@ -> used to define class level variables
      @@times_called += 1
    end
  end
end

def MathFunctions.triple(var) # Third way to define class method outside of the class.
  times_called
  var * 3
end

puts "### Classes - Class Methods and Variables"
#No instance required
puts MathFunctions.double 5
puts MathFunctions.triple(3)
puts MathFunctions.double(4)
puts MathFunctions.times_called


class Dog
  def to_s
    "Dog"
  end

  def bark
    "barks loudly"
  end
end

class SmallDog < Dog
  def bark      #override
    "barks quietly"
  end
end

puts "### Classes - Inheritance"
dog = Dog.new #BTW, new is a class method
small_dog = SmallDog.new

puts "#{dog}1 #{dog.bark}"
puts "#{small_dog}2 #{small_dog.bark}"

