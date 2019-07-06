class Person1

  def initialize (name, age) # Constructor
    @name = name  # instance variable
    @age = age    # instance variable
  end

  def get_info
    @additional_info = "Interesting" # on the spot instance variable. available to all instances.
    "Name: #{@name}, age: #{@age}"
  end

end

puts "### Classes"
person1 = Person1.new("Joe", 14)
p person1
p person1.instance_variables
puts person1.get_info
p person1.instance_variables


## Getters and Setters
class Person2
  def initialize (name, age) # Constructor
    @name = name  # instance variable
    @age = age    # instance variable
  end

  #getter
  def name
    @name
  end

  #settter
  def name= (new_name)
    @name = new_name
  end
end

puts "### Getters and Setters"
person2 = Person2.new("Joe", 14)
puts person2.name
person2.name = "Mike"
puts person2.name


class Person3
  attr_accessor :name, :age #getter and setters for name and age
end

puts "### Getters and Setters Accessor way"
person3 = Person3.new #uninitialized instance.
p person3.name
person3.name = "Mike"
person3.age = 15
puts person3.name
puts person3.age
person3.age = "fifteen"
puts person3.age


class Person4
  attr_reader   :age
  attr_accessor :name

  def initialize(name, ageVar) #constructor
    @name = name
    self.age = ageVar # call age setter method below. If self is not used this is treated as local variable.
    puts age
  end

  def age= (new_age)
    @age = new_age unless new_age > 120
  end
end

puts "### Self and sanity check before instance variable assignment"
person4 = Person4.new("Kim", 13)
puts "My age is #{person4.age}"
person4.age = 130
puts person4.age
