require_relative "../shared/utils"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

GRID = INPUT.map(&:chars)
H = GRID.length
W = GRID.first.length

DISTANCE_FROM_START = Array.new(H) { Array.new(W, nil) }
DISTANCE_TO_END = Array.new(H) { Array.new(W, nil) }

def cheats_from(sr, sc, limit)
  res = []

  ((sr - limit)..(sr + limit)).each do |r|
    next if r < 0
    next unless r < H
    dr = (r - sr).abs
    max_dc = limit - dr
    ((sc - max_dc)..(sc + max_dc)).each do |c|
      next if c < 0
      next unless c < W
      dc = (c - sc).abs
      res << [r, c, dr + dc]
    end
  end

  res
end

def helper(limit)
  res = []

  H.times.each do |sr|
    W.times.each do |sc|
      one = DISTANCE_FROM_START[sr][sc]
      next unless one

      cheats_from(sr, sc, limit).each do |er, ec, dist|
        two = DISTANCE_TO_END[er][ec]
        next unless two

        res << one + two + dist
      end
    end
  end

  res
end

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

GridBFS.new(GRID, start_row, start_col).execute.each do |state|
  row, col, path = state
  DISTANCE_FROM_START[row][col] = path.length
end

GridBFS.new(GRID, end_row, end_col).execute.each do |state|
  row, col, path = state
  DISTANCE_TO_END[row][col] = path.length
end

no_cheats = DISTANCE_TO_END[start_row][start_col]

part1 = helper(2).count { no_cheats - _1 >= 100 }
part2 = helper(20).count { no_cheats - _1 >= 100 }

puts part1
puts part2
