INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

ADJACENTS = Hash.new { |h, k| h[k] = [] }

INPUT.map { |line| line.split("-") }.each do |a, b|
  ADJACENTS[a] << b
  ADJACENTS[b] << a
end

CACHE = {}

def find_all_paths(cave, path, visited, exception, make_an_exception)
  CACHE[[cave, visited, exception, make_an_exception]] ||= find_all_paths_helper(cave, path, visited, exception, make_an_exception)
end

def find_all_paths_helper(cave, path, visited, exception, make_an_exception)
  return [path] if cave == 'end'

  ADJACENTS[cave].inject([]) do |res, next_cave|
    next_path = path + [next_cave]
    next_visited = visited.merge(next_cave => next_cave.downcase == next_cave)
    next_exception = exception || visited[next_cave]

    can_make_an_exception = make_an_exception && !exception && next_cave != 'start' && next_cave != 'end'

    if !visited[next_cave] || can_make_an_exception
      res + find_all_paths(next_cave, next_path, next_visited, next_exception, make_an_exception)
    else
      res
    end
  end
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
