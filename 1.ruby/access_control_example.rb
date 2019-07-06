
class Car
  def initialize(speed, comfort)
    @rating = speed * comfort
  end

  # Cannot set rating from outside. There is not setter for rating.
  def rating
    @rating
  end
end

puts "### AccessControl - Encapsulation"
puts Car.new(4, 5).rating

puts '### Access Control -  Different ways to specify access control (private, protected and public)'
#By default access control of variables and methods within the class is Public.
class MyAlgorithm
  private
    def test1
      "Private"
    end
  protected
    def test2
      "Protected"
    end
  public
    def test3
      "Public"
    end
end


class Another
  def test1
    "Private as declared later on"
  end

  private :test1
end


class Person
  def initialize(age)
    self.age = age  # Legal. This is allowed.
    puts my_age
    #puts self.my_age #Illegal. CANNOT USE self or any other receiver.
  end
  private
    def my_age
      @age
    end

    def age=(age)
      @age = age
    end
end

puts "### Access Control - Private Access"
Person.new(25)
