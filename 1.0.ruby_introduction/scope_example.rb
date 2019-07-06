# Methods and classes begin new scope of a variable.
# Use 'local_variables' method to see which variables are in scope.
#
puts "### Scope - Basics"
v1 = "outside"

class MyClass
  def my_method
    #p v1 #Exception will be thrown as v1 is out of scope
    v1 = "inside"
    p v1
    p local_variables
  end
end

p v1
obj = MyClass.new
obj.my_method

p local_variables
p self

puts "### Scope - Constants"
module Test
  PI = 3.14
  class Test2
    def what_is_PI
      puts PI
    end
  end
end

Test::Test2.new.what_is_PI

module MyModule
  MyConstant = "Outer Constant"
  class MyClass
    puts MyConstant # outer
    MyConstant = "Inner Constant"
    puts MyConstant #Inner
  end
  puts MyConstant
end


puts "### Scope - Blocks"
#Blocks inherit outer scope.
# Block is a closure: Remembers the context in which it is defined and uses that context whenever it is called.
#
arr = [5,4,1]
cur_number = 10
arr.each do |num|
  some_var = 10   #Not available outside
  print cur_number.to_s + " "
end
puts
puts cur_number
