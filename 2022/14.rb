INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

paths = INPUT.map do |line|
  line.split(' -> ').map { _1.split(',').map(&:to_i) }
end

points = paths.flatten(1)
minx, maxx = points.map(&:first).minmax
miny, maxy = points.map(&:last).minmax
miny = [miny, 0].min

grid = Array.new(maxy - miny + 1) { Array.new(maxx - minx + 1, '.') }
grid[0 - miny][500 - minx] = '+'

paths.each do |path|
  path.each_cons(2) do |p1, p2|
    x1, y1 = p1
    x2, y2 = p2

    dx = (x2 - x1) <=> 0
    dy = (y2 - y1) <=> 0

    loop do
      grid[y1 - miny][x1 - minx] = '#'
      break if x1 == x2 && y1 == y2

      x1 += dx
      y1 += dy
    end
  end
end

part1 = 0

loop do
  sandx = 500
  sandy = 0

  rest = false

  loop do
    break if sandx < minx
    break if sandx > maxx
    break if sandy < miny
    break if sandy > maxy

    if sandy == maxy || grid[sandy + 1 - miny][sandx - minx] == '.'
      sandy += 1
    elsif sandx == minx || grid[sandy + 1 - miny][sandx - 1 - minx] == '.'
      sandy += 1
      sandx -= 1
    elsif sandx == maxx || grid[sandy + 1 - miny][sandx + 1 - minx] == '.'
      sandy += 1
      sandx += 1
    else
      grid[sandy - miny][sandx - minx] = 'o'
      rest = true
      break
    end
  end

  break unless rest

  part1 += 1
end

puts part1
