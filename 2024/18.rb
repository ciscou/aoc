require_relative "../shared/utils"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

W = 71
H = 71
GRID = W.times.map { H.times.map { "." } }

BYTES = INPUT.map { _1.split(",").map(&:to_i) }

class MyBFS < BFS
  def initialize(start_row, start_col)
    @start_row = start_row
    @start_col = start_col

    @v = Set.new
  end

  private

  def initial_state
    [@start_row, @start_col, []]
  end

  def neighbours(state)
    row, col, path = state

    ns = []

    ns << [row - 1, col, path + [[row - 1, col]]]
    ns << [row + 1, col, path + [[row + 1, col]]]
    ns << [row, col - 1, path + [[row, col - 1]]]
    ns << [row, col + 1, path + [[row, col + 1]]]

    ns.select do |row, col, _path|
      next false if row < 0
      next false if col < 0
      next false unless row < H
      next false unless col < W

      next false if GRID[row][col] == "#"

      true
    end
  end

  def visited?(state)
    row, col, _path = state

    if @v.add?([row, col])
      false
    else
      true
    end
  end
end

BYTES[0, 1024].each { |x, y| GRID[y][x] = "#" }

last_path = nil

MyBFS.new(0, 0).execute.each do |state|
  row, col, last_path = state

  if row == H - 1 && col == W - 1
    puts last_path.length
    break
  end
end

unreachable = false

BYTES[1024..-1].each do |x, y|
  GRID[y][x] = "#"

  next unless last_path.include?([y, x])

  break if unreachable
  unreachable = true

  MyBFS.new(0, 0).execute.each do |state|
    row, col, last_path = state

    if row == H - 1 && col == W - 1
      unreachable = false
      break
    end
  end

  puts [x, y].join(",") if unreachable
end
