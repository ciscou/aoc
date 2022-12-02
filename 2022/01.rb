INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

elves = INPUT.chunk { |line| line.empty? && nil }.map { |_, calories| calories.sum(&:to_i) }.sort

puts elves.last
puts elves.last(3).sum
