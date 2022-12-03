INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

rucksacks = INPUT.map do |line|
  compartiment_size = line.length / 2

  [line[0, compartiment_size], line[compartiment_size, compartiment_size]].map(&:chars)
end

part1 = rucksacks.sum do |compartiment1, compartiment2|
  common = (compartiment1 & compartiment2).first

  case common
  when 'a'..'z' then common.ord - 'a'.ord + 1
  when 'A'..'Z' then common.ord - 'A'.ord + 27
  end
end

puts part1

part2 = rucksacks.each_slice(3).sum do |group|
  common = group.map { |c1, c2| c1 + c2 }.reduce(&:&).first

  case common
  when 'a'..'z' then common.ord - 'a'.ord + 1
  when 'A'..'Z' then common.ord - 'A'.ord + 27
  end
end

puts part2
