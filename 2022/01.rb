INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

max3 = INPUT.chunk { |line| line.empty? && nil }.map { |_, calories| calories.sum(&:to_i) }.max(3)

puts max3.first
puts max3.sum
