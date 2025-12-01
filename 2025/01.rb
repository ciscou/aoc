INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

n = 50
part1 = 0
part2 = 0

INPUT.each do |line|
  dir = line[0]
  count = line[1..-1].to_i

  count.times do
    if dir == "L"
      n -= 1
    else
      n += 1
    end

    n %= 100
    part2 += 1 if n == 0
  end

  part1 += 1 if n == 0
end

puts part1
puts part2
