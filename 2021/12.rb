INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

ADJACENTS = Hash.new { |h, k| h[k] = [] }

INPUT.map { |line| line.split("-") }.each do |a, b|
  ADJACENTS[a] << b
  ADJACENTS[b] << a
end

def part1
  stack = []
  stack.push(['start', {'start' => true}])

  res = 0

  until stack.empty?
    cave, visited = stack.pop

    if cave == 'end'
      res += 1
      next
    end

    ADJACENTS[cave].each do |next_cave|
      unless visited[next_cave]
        next_visited = visited.merge(next_cave => next_cave.downcase == next_cave)
        stack.push([next_cave, next_visited])
      end
    end
  end

  res
end

puts part1
