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

def cheats_from(sr, sc, limit)
  res = []

  ((sr-limit)..(sr+limit)).each do |r|
    ((sc-limit)..(sc+limit)).each do |c|
      dist = (r - sr).abs + (c - sc).abs
      next unless dist <= limit
      next if dist == 0

      next if r < 0
      next if c < 0
      next unless r < H
      next unless c < W
      next unless GRID[r][c] == "."

      res << [[r, c]] * dist
    end
  end

  return res

  # Dunno why this doesn't work
  # res = []
  #
  # q = []
  # q << [sr, sc, []]
  #
  # v = Set.new
  #
  # until q.empty?
  #   n = q.shift
  #   row, col, path = n
  #
  #   next if row < 0
  #   next if col < 0
  #   next unless row < H
  #   next unless col < W
  #
  #   next if path.length > limit
  #
  #   res << path if path.length >= 2 && GRID[row][col] == "." && path[0..-2].all? { |r, c| GRID[r][c] == "#" }
  #   # next unless path.empty? || GRID[row][col] == "#"
  #
  #   next unless v.add?([row, col])
  #
  #   q << [row - 1, col, path + [[row - 1, col]]]
  #   q << [row + 1, col, path + [[row + 1, col]]]
  #   q << [row, col - 1, path + [[row, col - 1]]]
  #   q << [row, col + 1, path + [[row, col + 1]]]
  # end
  #
  # res
end

bfs(start_row, start_col, DISTANCE_FROM_START)
bfs(end_row, end_col, DISTANCE_TO_END)

def saves(limit, no_cheats)
  saves = []

  H.times.each do |sr|
    W.times.each do |sc|
      one = DISTANCE_FROM_START[sr][sc]
      next unless one

      cheats_from(sr, sc, limit).each do |path|
        er, ec = path.last

        two = DISTANCE_TO_END[er][ec]
        next unless two

        saves << no_cheats - (one + two + path.length)
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
