INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

elves = []
elf = []

INPUT.each do |line|
  if line.empty?
    elves << elf
    elf = []
  else
    elf << line.to_i
  end
end

elves << elf

puts elves.map(&:sum).max

puts elves.map(&:sum).sort.reverse[0, 3].sum
