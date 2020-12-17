input = "01110110101001000"
length = 35651584

data = input.chars.map { |c| c == "1" }

while data.length < length
  a = data.dup
  b = a.dup
  b.reverse!
  b.map! { |c| !c }
  data = a + [false] + b
end

data = data[0, length]
checksum = data.each_slice(2).map do |a, b|
  a == b
end
until checksum.length.odd?
  checksum = checksum.each_slice(2).map do |a, b|
    a == b
  end
end

p data.map { |c| c ? 1 : 0 }.join("")
p checksum.map { |c| c ? 1 : 0 }.join("")
