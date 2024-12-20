INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

GRID = INPUT.map { _1.chars }
H = GRID.length
W = GRID.first.length

start_row = nil
start_col = nil
end_row = nil
end_col = nil

H.times do |r|
  W.times do |c|
    if GRID[r][c] == "S"
      start_row = r
      start_col = c
      GRID[r][c] = "."
    end
    if GRID[r][c] == "E"
      end_row = r
      end_col = c
      GRID[r][c] = "."
    end
  end
end

DISTANCE_FROM_START = H.times.map { W.times.map { nil } }
DISTANCE_TO_END = H.times.map { W.times.map { nil } }

def bfs(start_row, start_col, h)
  q = []
  q << [start_row, start_col, 0]

  until q.empty?
    n = q.shift
    row, col, steps = n

    next if row < 0
    next if col < 0
    next unless row < H
    next unless col < W

    next if GRID[row][col] == "#"

    next if h[row][col]
    h[row][col] = steps

    q << [row - 1, col, steps + 1]
    q << [row + 1, col, steps + 1]
    q << [row, col - 1, steps + 1]
    q << [row, col + 1, steps + 1]
  end

  Float::INFINITY
end

bfs(start_row, start_col, DISTANCE_FROM_START)
bfs(end_row, end_col, DISTANCE_TO_END)

def saves(limit, no_cheats)
  saves = []

  H.times.each do |sr|
    W.times.each do |sc|
      one = DISTANCE_FROM_START[sr][sc]
      next unless one

      H.times.each do |er|
        W.times.each do |ec|
          two = DISTANCE_TO_END[er][ec]
          next unless two

          cheat = (er - sr).abs + (ec - sc).abs
          next unless cheat <= limit

          saves << no_cheats - (one + two + cheat)
        end
      end
    end
  end

  saves
end

no_cheats = DISTANCE_TO_END[start_row][start_col]

part1 = 0
saves(2, no_cheats).each do |save|
  part1 += 1 if save >= 100
end
puts part1

part2 = 0
saves(20, no_cheats).each do |save|
  part2 += 1 if save >= 100
end
puts part2
