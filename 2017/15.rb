input = <<EOS
Generator A starts with 591
Generator B starts with 393
EOS

generator_a_prev_value = input.lines.first.split(" ").last.to_i
generator_b_prev_value = input.lines.last .split(" ").last.to_i

generator_a = Enumerator.new do |y|
  loop do
    generator_a_prev_value = (generator_a_prev_value * 16807) % 2147483647
    y << generator_a_prev_value if generator_a_prev_value % 4 == 0
  end
end

generator_b = Enumerator.new do |y|
  loop do
    generator_b_prev_value = (generator_b_prev_value * 48271) % 2147483647
    y << generator_b_prev_value if generator_b_prev_value % 8 == 0
  end
end

matches = 0

5_000_000.times do |i|
  a = generator_a.next
  b = generator_b.next

  if a % (2 ** 16) == b % (2 ** 16)
    matches += 1
  end
end

puts matches
