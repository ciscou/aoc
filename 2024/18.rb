require_relative "../shared/utils"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

W = 71
H = 71
GRID = W.times.map { H.times.map { "." } }

BYTES = INPUT.map { _1.split(",").map(&:to_i) }

BYTES[0, 1024].each { |x, y| GRID[y][x] = "#" }

last_path = nil

GridBFS.new(GRID, 0, 0).execute.each do |state|
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

  GridBFS.new(GRID, 0, 0).execute.each do |state|
    row, col, last_path = state

    if row == H - 1 && col == W - 1
      unreachable = false
      break
    end
  end

  puts [x, y].join(",") if unreachable
end
