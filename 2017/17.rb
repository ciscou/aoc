input = 328

buffer = [0] * 50_000_000
length = 1
pos = 0
(1..50_000_000).each do |value|
  puts value if value % 1_000 == 0

  pos += input
  pos %= length

  pos = pos + 1
  buffer[pos] = value
  length += 1
end

idx = buffer.index(0)
puts buffer[idx + 1]
