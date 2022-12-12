INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = INPUT.map(&:chars)

pos = nil
target = nil

grid.each_with_index do |row, r|
  row.each_with_index do |cell, c|
    if cell == "S"
      pos = [r, c]
      row[c] = "a"
    end
    if cell == "E"
      target = [r, c]
      row[c] = "z"
    end
  end
end

def bfs(grid, row, col, downwards=false)
  q = []
  visited = {}

  q << [row, col, 0]

  until q.empty?
    row, col, steps = q.shift

    next if visited[[row, col]]
    visited[[row, col]] = true

    if yield(row, col)
      return steps
    end

    [
      [ 0,  1],
      [ 0, -1],
      [ 1,  0],
      [-1,  0],
    ].each do |dr, dc|
      next_row, next_col, next_steps = row + dr, col + dc, steps + 1

      next if next_row < 0 || next_row >= grid.length || next_col < 0 || next_col >= grid[next_row].length
      if downwards
        next if grid[next_row][next_col].ord - grid[row][col].ord < -1
      else
        next if grid[next_row][next_col].ord - grid[row][col].ord > 1
      end

      q << [next_row, next_col, steps+1]
    end
  end

  return -1
end

part1 = bfs(grid, pos[0], pos[1]) do |row, col|
  row == target[0] && col == target[1]
end
puts part1

part2 = bfs(grid, target[0], target[1], true) do |row, col|
  grid[row][col] == "a"
end
puts part2
