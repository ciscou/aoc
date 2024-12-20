INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

GRID = INPUT.map(&:chars)
H = GRID.length
W = GRID.first.length

DISTANCE_FROM_START = Array.new(H) { Array.new(W, nil) }
DISTANCE_TO_END = Array.new(H) { Array.new(W, nil) }

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
end

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

bfs(start_row, start_col, DISTANCE_FROM_START)
bfs(end_row, end_col, DISTANCE_TO_END)

no_cheats = DISTANCE_TO_END[start_row][start_col]

part1 = helper(2).count { no_cheats - _1 >= 100 }
part2 = helper(20).count { no_cheats - _1 >= 100 }

puts part1
puts part2
