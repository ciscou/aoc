INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

elves = INPUT.chunk { |line| line.empty? && nil }.map { |_, calories| calories.sum(&:to_i) }

puts elves.max
puts elves.sort.last(3).sum
