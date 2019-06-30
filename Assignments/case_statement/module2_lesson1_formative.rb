
some_var = "false"
another_var = "nil"

case some_var
  when some_var == "pink elephant"
    puts "Don't think about the pink elephant!"
  when another_var.nil?
    puts "Looks like this one should execute"
  when some_var == false
    puts "I guess nothing matched... But why?" # This one did not get execute because string and boolean did not match
  else
    puts "I guess nothing matched... But why?"
end
