INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

ADJACENTS = Hash.new { |h, k| h[k] = [] }

INPUT.map { |line| line.split("-") }.each do |a, b|
  ADJACENTS[a] << b
  ADJACENTS[b] << a
end

def find_all_paths(make_an_exception)
  stack = []
  stack.push(['start', ['start'], {'start' => true}, false])

  res = []

  until stack.empty?
    node = stack.pop
    cave, path, visited, exception = node

    count_caves = path.group_by(&:itself)
    lowercase_caves = path.select { |x| x.downcase == x && x != 'start' && x != 'end' }

    if cave == 'end'
      res << path
      next
    end

    ADJACENTS[cave].each do |next_cave|
      next_visited = visited.merge(next_cave => next_cave.downcase == next_cave)
      next_path = path + [next_cave]
      can_make_an_exception = make_an_exception && !exception && next_cave != 'start' && next_cave != 'end'

      if !visited[next_cave]
        stack.push([next_cave, next_path, next_visited, exception])
      elsif can_make_an_exception
        stack.push([next_cave, next_path, next_visited, true])
      end
    end
  end

  res
end

def part1
  find_all_paths(false)
end

def part2
  find_all_paths(true)
end

puts part1.length
puts part2.length
