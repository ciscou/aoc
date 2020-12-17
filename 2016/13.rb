input = "1352"

grid = Hash.new do |h1, y|
  h1[y] = Hash.new do |h2, x|
    n = x*x + 3*x + 2*x*y + y + y*y + input.to_i
    ones = n.to_s(2).chars.select { |c| c == "1" }
    ones.length.even? ? "." : "#"
  end
end

def valid_move?(grid, visited, row, col)
  return false if row < 0
  return false if col < 0
  # return false if row > grid.length
  # return false if col > grid.first.length

  return false if visited[row][col]

  return false if grid[row][col] == "#"

  true
end

def bfs(grid, start_row, start_col, target_row, target_col)
  visited = Hash.new { |h, k| h[k] = {} }
  queue = []

  visited[start_row][start_col] = true
  queue.push([start_row, start_col, 0])

  min_dist = 999_999_999_999

  until queue.empty?
    node = queue.shift()

    row, col, dist = node

    # if row == target_row && col == target_col
    #   min_dist = dist
    #   break
    # end

    available_moves = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    available_moves.each do |drow, dcol|
      if dist < 50 && valid_move?(grid, visited, row + drow, col + dcol)
        visited[row + drow][col + dcol] = true
        queue.push([row + drow, col + dcol, dist + 1])
      end
    end
  end

  # min_dist
  visited.values.sum(&:length)
end

7.times do |row|
  puts 10.times.map { |col| grid[row][col] }.join(" ")
end
puts bfs(grid, 1, 1, 39, 31)
