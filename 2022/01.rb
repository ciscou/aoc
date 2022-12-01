INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

elves = INPUT.chunk { |line| !line.empty? || nil }.map { |_, calories| calories.map(&:to_i).sum }.sort.reverse

puts elves[0]
puts elves[0, 3].sum
