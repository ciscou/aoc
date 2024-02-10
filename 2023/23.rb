INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = {}

part2 = true

INPUT.each_with_index do |line, row|
  line.chars.each_with_index do |char, col|
    char = "." if part2 && %w[< > ^ v].include?(char)
    grid[[row, col]] = char
  end
end

def dfs(grid, rows, cols, row, col, visited)
  return if row < 0
  return if col < 0
  return if row >= rows
  return if col >= cols

  if row == rows-1 && col==cols-2
    puts visited.size
    return
  end

  return if visited[[row, col]]
  return if grid[[row, col]] == "#"

  visited[[row, col]] = true

  case grid[[row, col]]
  when "."
    dfs(grid, rows, cols, row-1, col, visited)
    dfs(grid, rows, cols, row+1, col, visited)
    dfs(grid, rows, cols, row, col-1, visited)
    dfs(grid, rows, cols, row, col+1, visited)
  when "v"
    dfs(grid, rows, cols, row+1, col, visited)
  when "^"
    dfs(grid, rows, cols, row-1, col, visited)
  when ">"
    dfs(grid, rows, cols, row, col+1, visited)
  when "<"
    dfs(grid, rows, cols, row, col-1, visited)
  else
    raise "invalid cell #{grid[[row, col]].inspect}"
  end

  visited.delete([row, col])
end

rows = grid.keys.map(&:first).max + 1
cols = grid.keys.map(&:last).max + 1

dfs(grid, rows, cols, 0, 1, {})
