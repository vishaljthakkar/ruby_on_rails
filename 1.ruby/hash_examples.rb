puts "### Hashes"
# => Hash Rocket (creation)

editor_props = {
    "font" => "Arial",
    "size" => 12,
    "color" => "red"
}

puts editor_props.length
puts editor_props["font"]
editor_props["background"] = "Blue"

editor_props.each_pair do |key, value|
  puts "Key: #{key} value: #{value}"
end

# non existent entry in Hash returns 'nil'
# Hash created with Hash.new(0) returns 0 for non existent entry.

word_freq = Hash.new(0)
sentence = "Boom Chicka Pop Pop Boom"
sentence.split.each do |word|
  word_freq[word.downcase] += 1
end

p word_freq

# Ruby hashes maintain the order of insertion
# Can use symbols as keys
# If Hash is the last argument to a method then {} are optional
#


family_tree_19 = {oldest: "Jim", older: "Joe", younger: "Jack"}
family_tree_19[:younger] = "Jeremy"
p family_tree_19

#Named parameters "like" behavior. . .
# method takes hash as input. Defined below with default hash
def adjust_color(props = {foreground: "red", background: "white"})
  puts "Foreground: #{props[:foreground]}" if props[:foreground]
  puts "Background: #{props[:background]}" if props[:background]
end

adjust_color
adjust_color({:foreground => "green"})
adjust_color({foreground: "grey"})
adjust_color background: "yellow"
adjust_color :background => "magenta"

