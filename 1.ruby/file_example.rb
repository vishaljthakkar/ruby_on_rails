puts "### Reading from a file"

File.foreach('files/test.txt') do |line|
  puts line
  p line.chomp # chops off newline character
  p line.split # array of words in line
end

puts "### File not found exception. Uncomment code if you want to see"
# File.foreach('files/donotexist.txt') do |line|
#   puts line.chomp
# end

puts "### Handle file not found exception"
begin
  File.foreach('files/donotexist.txt') do |line|
    puts line.chomp
  end
rescue Exception => e
  puts e.message
  puts "Lets pretend this did not happen. . . "
end

puts "### File exists."
File.exist? 'files/test.txt'
  File.foreach('files/test.txt') do |line|
    puts line.chomp
end

puts "### Writing to a file - files/new_file.txt"
File.open('files/new_file.txt', 'w') do |file|
  file.puts "one line"
  file.puts "Another"
end
