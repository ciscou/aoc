INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

ADJACENTS = Hash.new { |h, k| h[k] = [] }

INPUT.map { |line| line.split("-") }.each do |a, b|
  ADJACENTS[a] << b
  ADJACENTS[b] << a
end

CACHE = {}

def find_all_paths(start, path, visited, exception, make_an_exception)
  CACHE[[start, visited, exception, make_an_exception]] ||= find_all_paths_helper(start, path, visited, exception, make_an_exception)
end

def find_all_paths_helper(start, path, visited, exception, make_an_exception)
  return [path.dup] if start == 'end'

  res = []

  ADJACENTS[start].each do |adjacent|
    next_exception = exception || visited[adjacent]

    can_make_an_exception = make_an_exception && !exception && adjacent != 'start' && adjacent != 'end'

    if !visited[adjacent] || can_make_an_exception
      was_visited = visited[adjacent]
      visited[adjacent] = true if adjacent.downcase == adjacent
      path.push(adjacent)

      res += find_all_paths(adjacent, path, visited, next_exception, make_an_exception)

      path.pop
      visited[adjacent] = was_visited
    else
      res
    end
  end

  res
end

def find_all_paths_from(start, make_an_exception)
  find_all_paths(start, [start], { start => true }, false, make_an_exception)
end

def part1
  find_all_paths_from('start', false)
end

def part2
  find_all_paths_from('start', true)
end

puts part1.length
puts part2.length
