INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

DIRECTIONS = INPUT.first.chars.map { _1 == "R" ? 1 : 0 }

NODES = INPUT[2..-1].inject({}) do |h, line|
  from, to = line.split(" = ")
  h[from] = to[1..-2].split(", ")
  h
end

part1 = 0
pos = "AAA"
until pos == "ZZZ"
  pos = NODES[pos][DIRECTIONS[part1 % DIRECTIONS.length]]
  part1 += 1
end
puts part1

cycles = Hash.new { |h, k| h[k] = [] }
part2 = 0
pos = NODES.keys.select { _1.end_with?("A") }
until pos.all? { _1.end_with?("Z") } || part2 > 100_000
  pos.each { cycles[_1] << part2 if _1.end_with?("Z") }
  pos = pos.map { NODES[_1][DIRECTIONS[part2 % DIRECTIONS.length]] }
  part2 += 1
end
puts cycles.values.map(&:first).reduce(:lcm)
