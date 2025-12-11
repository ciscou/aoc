require "json"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def flood_fill(grid, x, y, seen=Set.new)
  return unless grid[y][x] == " "
  return unless seen.add?([y, x])

  grid[y][x] = "#"

  flood_fill(grid, x-1, y, seen)
  flood_fill(grid, x+1, y, seen)
  flood_fill(grid, x, y-1, seen)
  flood_fill(grid, x, y+1, seen)
end


def helper?(grid, xs, ys, c1, c2)
  x1, y1 = c1
  x2, y2 = c2

  x1 = xs.index(x1)
  x2 = xs.index(x2)
  y1 = ys.index(y1)
  y2 = ys.index(y2)

  # return false unless grid[y1][x1] == "O"
  # return false unless grid[y2][x2] == "O"
  # return false unless grid[y1][x2] == "O"
  # return false unless grid[y2][x1] == "O"

  x1, x2 = [x1, x2].minmax
  y1, y2 = [y1, y2].minmax

  (x1..x2).each do |x|
    (y1..y2).each do |y|
      return false unless %w[# O].include? grid[y][x]
    end
  end

  true
end

corners = INPUT.map { it.split(",").map(&:to_i) }

part1 = corners.combination(2).map do |c1, c2|
  x1, y1 = c1
  x2, y2 = c2

  w = (x1 - x2).abs + 1
  h = (y1 - y2).abs + 1

  w * h
end.max

puts part1

# corner compression

xs = corners.map(&:first).sort.uniq
ys = corners.map(&:last).sort.uniq

compressed_corners = corners.map do |x, y|
  [xs.index(x), ys.index(y)]
end

grid = ys.length.times.map { xs.length.times.map { " " } }

(compressed_corners + [compressed_corners.first]).each_cons(2).each do |c1, c2|
  x1, y1 = c1
  x2, y2 = c2
  dx = x2 - x1
  dy = y2 - y1

  dx = 1 if dx > 0
  dx = -1 if dx < 0
  dy = 1 if dy > 0
  dy = -1 if dy < 0

  loop do
    grid[y1][x1] = "O"

    x1 += dx
    y1 += dy

    break if x2 == x1 && y2 == y1
  end
end

compressed_corners.each do |c|
  x, y = c
  grid[y][x] = "O"
end

# puts
# grid.each { puts it.join }

# flood_fill(grid, 2, 1)
flood_fill(grid, 100, 100)

# puts
# grid.each { puts it.join }

corners = INPUT.map { it.split(",").map(&:to_i) }

part2 = corners.combination(2).map do |c1, c2|
  next unless helper?(grid, xs, ys, c1, c2)

  x1, y1 = c1
  x2, y2 = c2

  w = (x1 - x2).abs + 1
  h = (y1 - y2).abs + 1

  [x1, y1, x2, y2, xs.index(x1), ys.index(y1), xs.index(x2), ys.index(y2), w * h]
end.compact.sort_by(&:last)

# puts

# puts grid.to_json
pp part2.last(2)

if false
x1, y1, x2, y2 = part2[-1]
x1, x2 = [x1, x2].minmax
y1, y2 = [y1, y2].minmax
(x1..x2).each do |x|
  (y1..y2).each do |y|
    # grid[y][x] = "."
  end
end

File.open("grid1bis.ppm", "w") do |f|
  f.puts "P2"
  f.puts [grid.first.length, grid.length].join(" ")
  f.puts 15
  grid.each do |line|
    line = line.map do |cell|
      case cell
      when " " then 0
      when "." then 3
      when "O" then 12
      else 15
      end
    end
    f.puts line.join(" ")
  end
end
end
