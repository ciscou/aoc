INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

GRID = INPUT.map(&:chars)
H = GRID.length
W = GRID.first.length

reindeer_row = nil
reindeer_col = nil
reindeer_dr = 0
reindeer_dc = 1

H.times do |r|
  W.times do |c|
    if GRID[r][c] == "S"
      GRID[r][c] = "."
      reindeer_row = r
      reindeer_col = c
    end
  end
end

def dijstra(row, col, dr, dc, visited, cost, path, h)
  return Float::INFINITY if row < 0
  return Float::INFINITY if col < 0
  return Float::INFINITY unless row < H
  return Float::INFINITY unless col < W

  return Float::INFINITY if GRID[row][col] == "#"

  if GRID[row][col] == "E"
    h[cost] ||= []
    h[cost] << path
    return cost
  end

  # poor man's dijstra, if only there were a priority queue in ruby stdlib...
  return Float::INFINITY if visited[[row, col, dr, dc]] < cost
  visited[[row, col, dr, dc]] = cost

  best = Float::INFINITY

  best = [best, dijstra(row + dr, col + dc, dr, dc, visited, cost + 1, path + [[row + dr, col + dc]], h)].min

  case [dr, dc]
  when [0, 1]
    best = [best, dijstra(row, col, 1, 0, visited, cost + 1000, path, h)].min
    best = [best, dijstra(row, col, -1, 0, visited, cost + 1000, path, h)].min
  when [0, -1]
    best = [best, dijstra(row, col, 1, 0, visited, cost + 1000, path, h)].min
    best = [best, dijstra(row, col, -1, 0, visited, cost + 1000, path, h)].min
  when [1, 0]
    best = [best, dijstra(row, col, 0, 1, visited, cost + 1000, path, h)].min
    best = [best, dijstra(row, col, 0, -1, visited, cost + 1000, path, h)].min
  when [-1, 0]
    best = [best, dijstra(row, col, 0, 1, visited, cost + 1000, path, h)].min
    best = [best, dijstra(row, col, 0, -1, visited, cost + 1000, path, h)].min
  else
    raise
  end

  best
end

visited = Hash.new(Float::INFINITY)
h = {}
part1 = dijstra(reindeer_row, reindeer_col, reindeer_dr, reindeer_dc, visited, 0, [[reindeer_row, reindeer_col]], h)
puts part1
set = Set.new
h[part1].each do |path|
  path.each { set.add _1 }
end
part2 = set.size
puts part2
