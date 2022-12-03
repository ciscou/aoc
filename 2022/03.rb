INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def priority(item_type)
  case item_type
  when 'a'..'z' then item_type.ord - 'a'.ord + 1
  when 'A'..'Z' then item_type.ord - 'A'.ord + 27
  end
end

rucksacks = INPUT.map(&:chars)

part1 = rucksacks.sum do |rucksack|
  containers = rucksack.each_slice(rucksack.length / 2)
  common = containers.reduce(:&)

  priority(common.first)
end
puts part1

part2 = rucksacks.each_slice(3).sum do |group|
  common = group.reduce(:&)

  priority(common.first)
end
puts part2
