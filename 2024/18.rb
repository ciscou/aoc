INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

W = 71
H = 71
GRID = W.times.map { H.times.map { "." } }

BYTES = INPUT.map { _1.split(",").map(&:to_i) }

def bfs(start_row, start_col, end_row, end_col)
  q = []
  q << [start_row, start_col, 0]

  v = Set.new

  until q.empty?
    n = q.shift
    row, col, steps = n

    next if row < 0
    next if col < 0
    next unless row < H
    next unless col < W

    next if GRID[row][col] == "#"

    next if v.include?([row, col])
    v.add([row, col])

    return steps if row == end_row && col == end_col

    q << [row - 1, col, steps + 1]
    q << [row + 1, col, steps + 1]
    q << [row, col - 1, steps + 1]
    q << [row, col + 1, steps + 1]
  end
  nil
end

BYTES[0, 1024].each { |x, y| GRID[y][x] = "#" }

part1 = bfs(0, 0, H-1, W-1)
puts part1
