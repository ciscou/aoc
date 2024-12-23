INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

connections = Hash.new { |h, k| h[k] = {} }

INPUT.map { |line| line.split("-") }.each do |a, b|
  connections[a][b] = true
  connections[b][a] = true
end

part1 = 0

seen = Set.new

connections.each do |from, others|
  next unless from.start_with?("t")

  others.keys.combination(2).each do |to1, to2|
    if connections[to1][to2] && seen.add?([from, to1, to2].to_set)
      part1 += 1 
    end
  end
end

puts part1

part2 = []

connections.each do |from, others|
  nodes = [from] + others.keys

  ((part2.length + 1)..nodes.length).each do |size|
    nodes.combination(size) do |set|
      next unless set.all? do |node|
        others = set - [node]

        others.all? do |other|
          connections[node][other]
        end
      end

      part2 = set
    end
  end
end

puts part2.sort.join(",")
