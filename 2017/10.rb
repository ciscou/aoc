input = "206,63,255,131,65,80,238,157,254,24,133,2,16,0,1,3"

numbers = 256.times.to_a
current_position = 0
skip_size = 0
lengths = input.chars.map(&:ord)
lengths += [17, 31, 73, 47, 23]

64.times do
  lengths.each do |length|
    reversed_numbers = (numbers + numbers).slice(current_position, length).reverse
    reversed_numbers.each_with_index do |n, i|
      numbers[(current_position + i) % numbers.length] = n
    end

    current_position += length + skip_size
    skip_size += 1

    current_position %= numbers.length
  end
end

hash = numbers.each_slice(16).map { |slice| slice.inject(:^) }

puts hash.map { |n| res = n.to_s(16).rjust(2, "0") }.join("")
