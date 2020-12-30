input = <<EOS
12320657
9659666
EOS

pk1 = input.lines.first.to_i
pk2 = input.lines.last.to_i

def calculate_loop_size(pk)
  res = 0
  val = 1

  loop do
    break if val == pk

    val *= 7
    val %= 20201227
    res += 1
  end

  res
end

def perform_loop(subject, size)
  val = 1

  size.times do
    val *= subject
    val %= 20201227
  end

  val
end

l1 = calculate_loop_size(pk1)
l2 = calculate_loop_size(pk2)

puts perform_loop(pk1, l2)
puts perform_loop(pk2, l1)
