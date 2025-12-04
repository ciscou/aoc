INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = {}

INPUT.each_with_index do |line, r|
  line.chars.each_with_index do |char, c|
    grid[[r, c]] = char
  end
end

part1 = nil
part2 = 0

loop do
  to_remove = Set.new

  grid.each do |pos, char|
    next unless char == "@"

    r, c = pos

    to_remove.add(pos) if [
        [r - 1, c - 1], [r -  1, c], [r - 1, c + 1],
        [r    , c - 1],              [r    , c + 1],
        [r + 1, c - 1], [r +  1, c], [r + 1, c + 1],
    ].select { grid[it] == "@" }.size < 4
  end

  break if to_remove.empty?

  part1 ||= to_remove.size
  part2 += to_remove.size

  to_remove.each { grid[it] = "." }
end

puts part1
puts part2
