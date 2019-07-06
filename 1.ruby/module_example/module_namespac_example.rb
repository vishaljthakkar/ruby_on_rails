# Module can be used as namespaces. Similar to packages in Java.
module Sports
  class Match
    attr_accessor :score
  end
end

module Patterns
  class Match
    attr_accessor :complete
  end
end

puts "### Modules - namespaces exmaple"
match1 = Sports::Match.new
match1.score = 45
puts match1.score

match2 = Patterns::Match.new
match2.complete = true
puts match2.complete
