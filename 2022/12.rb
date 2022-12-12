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

def bfs(grid, pos, target)
  q = []
  visited = {}

  q << [pos[0], pos[1], 0]
  visited[[pos[0], pos[1]]] = true

  until q.empty?
    row, col, steps = q.shift

    if row == target[0] && col == target[1]
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
      next if grid[next_row][next_col].ord - grid[row][col].ord > 1

      next if visited[[next_row, next_col]]
      visited[[next_row, next_col]] = true

      q << [next_row, next_col, steps+1]
    end
  end

  return -1
end

puts bfs(grid, pos, target)
