INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def build_grid
  grid = {}

  INPUT.each.with_index do |line, row|
    line.chars.map(&:to_i).each.with_index do |cell, col|
      grid[[row, col]] = cell
    end
  end

  grid
end

def perform_step(grid)
  flashed = {}

  grid.keys.each do |pos|
    grid[pos] += 1
  end
  grid.keys.each do |pos|
    flash(grid, pos, flashed)
  end
  grid.keys.each do |pos|
    if grid[pos] > 9
      grid[pos] = 0
    end
  end

  flashed.size
end

def neightbours_positions(grid, pos)
  row, col = pos

  [
    [row-1, col],
    [row+1, col],
    [row, col-1],
    [row, col+1],
    [row-1, col-1],
    [row+1, col+1],
    [row+1, col-1],
    [row-1, col+1]
  ].select { |pos| grid.key?(pos) }
end

def flash(grid, pos, flashed)
  return if flashed[pos]

  return unless grid[pos] > 9
  flashed[pos] = true

  neightbours_positions(grid, pos).each do |neightbour_pos|
    next if flashed[neightbour_pos]

    grid[neightbour_pos] += 1
    flash(grid, neightbour_pos, flashed)
  end
end

def part1
  grid = build_grid

  100.times.sum do
    perform_step(grid)
  end
end

def part2
  grid = build_grid

  step = 0
  loop do
    step += 1

    return step if perform_step(grid) == grid.size
  end
end

puts part1
puts part2
