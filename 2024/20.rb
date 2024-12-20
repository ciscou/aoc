INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = INPUT.map { _1.chars }
H = grid.length
W = grid.first.length

start_row = nil
start_col = nil
end_row = nil
end_col = nil

H.times do |r|
  W.times do |c|
    if grid[r][c] == "S"
      start_row = r
      start_col = c
      grid[r][c] = "."
    end
    if grid[r][c] == "E"
      end_row = r
      end_col = c
      grid[r][c] = "."
    end
  end
end

def bfs(grid, start_row, start_col, end_row, end_col, cheat_start_row, cheat_start_col)
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

    cheat = row == cheat_start_row && col == cheat_start_col

    if cheat
    else
      next if grid[row][col] == "#"
    end

    next if v.include?([row, col])
    v.add([row, col])

    return steps if row == end_row && col == end_col

    q << [row - 1, col, steps + 1]
    q << [row + 1, col, steps + 1]
    q << [row, col - 1, steps + 1]
    q << [row, col + 1, steps + 1]
  end

  raise "impossible"
end

no_cheats = bfs(grid, start_row, start_col, end_row, end_col, nil, nil)

saves = []

H.times.each do |r|
  W.times.each do |c|
    saves << no_cheats - bfs(grid, start_row, start_col, end_row, end_col, r, c)
    p saves
  end
end

part1 = 0
saves.each do |save|
  part1 += 1 if save >= 100
end
puts part1
