input = "3113322113"

def look_and_say(s)
  chunks = s.chars.chunk(&:itself)

  chunks.map do |chunk|
    "#{chunk.last.length}#{chunk.last.first}"
  end.join
end

50.times do
  input = look_and_say(input)
  puts input.length
end
