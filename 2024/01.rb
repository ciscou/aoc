INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

ids1 = []
ids2 = []

INPUT.each do |line|
  a, b = line.split("   ")
  ids1 << a.to_i
  ids2 << b.to_i
end

ids1.sort!
ids2.sort!

part1 = ids1.zip(ids2).sum { (_2 - _1).abs }
puts part1

ids2 = ids2.tally
part2 = ids1.sum { _1 * (ids2[_1] || 0) }
puts part2
