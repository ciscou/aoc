code_length = 0
memory_length = 0
recode_length = 0

while s = gets do
  s.chomp!

  code_length += s.length

  memory_string = s[1..-2].
    gsub(/\\\\/, "?").
    gsub(/\\"/, "?").
    gsub(/\\x[0-9a-f]{2}/, "?")

  memory_length += memory_string.length

  recode_string = s.inspect

  recode_length += recode_string.length

  if recode_string.length != s.inspect.length
    puts
    puts recode_string
    puts s.inspect
  end
end

puts code_length - memory_length
puts recode_length - code_length
