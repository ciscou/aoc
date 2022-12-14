INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

paths = INPUT.map do |line|
  line.split(' -> ').map { _1.split(',').map(&:to_i) }
end

points = paths.flatten(1)
minx, maxx = points.map(&:first).minmax
miny, maxy = points.map(&:last).minmax
miny = [miny, 0].min

grid = Hash.new do |h1, x|
  h1[x] = Hash.new do |h2, y|
    h2[y] = y > maxy + 1 ? "#" : "."
  end
end
grid[500][0] = '+'

paths.each do |path|
  path.each_cons(2) do |p1, p2|
    x1, y1 = p1
    x2, y2 = p2

    dx = (x2 - x1) <=> 0
    dy = (y2 - y1) <=> 0

    loop do
      grid[x1][y1] = '#'
      break if x1 == x2 && y1 == y2

      x1 += dx
      y1 += dy
    end
  end
end

part2 = 0

loop do
  sandx = 500
  sandy = 0

  rest = false

  loop do
    if grid[sandx][sandy + 1] == '.'
      sandy += 1
    elsif grid[sandx - 1][sandy + 1] == '.'
      sandy += 1
      sandx -= 1
    elsif grid[sandx + 1][sandy + 1] == '.'
      sandy += 1
      sandx += 1
    else
      grid[sandx][sandy] = 'o'
      rest = true
      break
    end
  end

  part2 += 1

  break if sandx == 500 && sandy == 0
end

puts part2
