# Mixin are way to share ready code among multiple classes. Similar to Interface but more.
# You can include builtin modules in your code as well.
module SayMyName
  attr_accessor :name

  def print_name
    puts "Name: #{@name}"
  end
end

class Person
  include SayMyName
end

class Company
  include SayMyName
end

puts "### Modules - module as mixin. include directive"
person = Person.new
person.name = "Joe" # Gets this variable from included module
person.print_name   # Same as above
company = Company.new
company.name = "ABC Corp"
company.print_name
