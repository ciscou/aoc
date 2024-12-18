require 'ruby2d'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

W = 71
H = 71
GRID = W.times.map { H.times.map { "." } }

BYTES = INPUT.map { _1.split(",").map(&:to_i) }

CELL_SIZE = 13

def bfs(start_row, start_col, end_row, end_col)
  q = []
  q << [start_row, start_col, [[start_row, start_col]]]

  v = Set.new

  until q.empty?
    n = q.shift
    row, col, path = n

    next if row < 0
    next if col < 0
    next unless row < H
    next unless col < W

    return path if row == end_row && col == end_col

    next if GRID[row][col] == "#"

    next if v.include?([row, col])
    v.add([row, col])

    [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0],
    ].each do |dr, dc|
      q << [row + dr, col + dc, path + [[row + dr, col + dc]]]
    end
  end

  []
end

# BYTES[0, 1024].each { |x, y| GRID[y][x] = "#" }
#
# part1 = bfs(0, 0, H-1, W-1)
# puts part1
#
# BYTES[1024..-1].each do |x, y|
#   GRID[y][x] = "#"
#   unless bfs(0, 0, H-1, W-1)
#     puts [x, y].join(",")
#     break
#   end
# end

def draw_grid(path, last_wall)
  H.times do |y|
    W.times do |x|
      if GRID[y][x] == "#"
        wall_color = "#505050"
        wall_color = "white" if last_wall == [y, x]
        Square.new(x: x * CELL_SIZE, y: y * CELL_SIZE, size: CELL_SIZE, color: wall_color)
      end
    end
  end

  path_color = "#CD5C5C"
  path_color = "#22A022" if path.last == [H-1, W-1]

  path.each do |y, x|
    Square.new(x: x * CELL_SIZE, y: y * CELL_SIZE, size: CELL_SIZE, color: path_color)
  end
end

bytes_idx = 0

bytes_idx.times do |i|
  col, row = BYTES[i]
  GRID[row][col] = "#"
end

update do
  col, row = BYTES[bytes_idx]
  GRID[row][col] = "#"
  last_wall = [row, col]

  path = bfs(0, 0, H-1, W-1)

  if path.empty?
    puts [col, row].join(",")
    path = bfs(0, 0, row, col)
  else
    bytes_idx += 1
  end

  clear
  draw_grid(path, last_wall)
end

set title: "Advent of Code 2024 15", width: CELL_SIZE * 71, height: CELL_SIZE * 71

show
