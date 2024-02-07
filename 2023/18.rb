INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

row, col = 0, 0

grid = {}
grid[[row, col]] = true
rightmost_wall = Hash.new(-Float::INFINITY)

INPUT.each do |line|
  dir, steps, _color = line.split
  steps = steps.to_i

  steps.times do
    case dir
    when "R"
      col += 1
    when "L"
      col -= 1
    when "U"
      row -= 1
    when "D"
      row += 1
    else
      raise "invalid dir #{dir.inspect}"
    end

    grid[[row, col]] = true
    rightmost_wall[row] = [rightmost_wall[row], col].max
  end
end

minrow, maxrow = grid.keys.map(&:first).minmax
mincol, maxcol = grid.keys.map(&:last).minmax

(minrow..maxrow).each do |row|
  (mincol..maxcol).each do |col|
    if grid[[row, col]]
      if row == 0 && col == 0
        print "@"
      else
        print "#"
      end
    else
      print "."
    end
  end
  puts
end

def floodfill(grid, row, col)
  return if grid[[row, col]]

  grid[[row, col]] = true

  floodfill(grid, row-1, col)
  floodfill(grid, row+1, col)
  floodfill(grid, row, col-1)
  floodfill(grid, row, col+1)
end

puts
puts
puts

if false
(minrow..maxrow).each do |row|
  inside = false
  wall = false

  (mincol..maxcol).each do |col|
    if grid[[row, col]]
      inside = !inside unless wall
      wall = true
    else
      if inside
        grid[[row, col]] = true if rightmost_wall[row] > col
      end
      wall = false
    end
  end
end
end

floodfill(grid, 1, 1)

(minrow..maxrow).each do |row|
  (mincol..maxcol).each do |col|
    if grid[[row, col]]
      if row == 0 && col == 0
        print "@"
      else
        print "#"
      end
    else
      print "."
    end
  end
  puts
end

puts
puts
puts

puts grid.size
