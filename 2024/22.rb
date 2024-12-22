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

part1 = secret_numbers.sum(&:last)
puts part1

secret_numbers.each do |ns|
  ns.map! { _1 % 10 }
end

diffs = Set.new

profit_for_diff = secret_numbers.map do |ns|
  h = {}
  ns.each_cons(5).each do |a, b, c, d, e|
    diff = [b - a, c - b, d - c, e - d]
    diffs.add(diff)
    h[diff] ||= e
  end
  h
end

part2 = 0

diffs.each do |diff|
  profit = 0

  profit_for_diff.each do |h|
    profit += h[diff] || 0
  end

  part2 = [part2, profit].max
end

puts part2
