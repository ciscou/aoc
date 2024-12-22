INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

secret_numbers = INPUT.map { [_1.to_i] }

2_000.times do
  secret_numbers.each do |ns|
    n = ns.last

    n ^= n * 64
    n %= 16777216

    n ^= n / 32
    n %= 16777216

    n ^= n * 2048
    n %= 16777216

    ns << n
  end
end

part1 = secret_numbers.map(&:last).sum
puts part1

secret_numbers.each do |ns|
  ns.map! { _1 % 10 }
end

diffs = Set.new

secret_numbers.each do |ns|
  ns.each_cons(5).each do |a, b, c, d, e|
    diffs.add([b - a, c - b, d - c, e - d])
  end
end

part2 = 0

puts diffs.size

diffs.each do |diff|
  profit = 0

  secret_numbers.each do |ns|
    ns.each_cons(5) do |a, b, c, d, e|
      next unless diff == [b - a, c - b, d - c, e - d]

      profit += e
      break
    end
  end

  part2 = [part2, profit].max
end

puts part2

# TODO: use a hash (four hashes?) to keep track of the profit for each prefix / buyer
