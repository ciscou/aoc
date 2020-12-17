def calculate_visibilities(map, row, col)
  asteroids = []

  map.length.times do |row|
    asteroids[row] = []

    map[row].length.times do |col|
      asteroids[row][col] = map[row][col]
    end
  end

  asteroids[row][col] = false

  asteroids.length.times do |drow|
    asteroids[row].length.times do |dcol|
      trace_ray(asteroids, row, col, drow-row, dcol-col)
    end
  end

  asteroids.sum do |row|
    row.sum do |col|
      col ? 1 : 0
    end
  end
end

def trace_ray(asteroids, row, col, drow, dcol)
  return if drow == 0 && dcol == 0

  gcd = drow.gcd(dcol)
  drow /= gcd
  dcol /= gcd

  hit = false

  while row >= 0 && col >= 0 && row < asteroids.length && col < asteroids.first.length
    asteroids[row][col] = false if hit

    hit ||= asteroids[row][col]

    row += drow
    col += dcol
  end
end

def laser(map, row, col, drow, dcol)
  return if drow == 0 && dcol == 0

  gcd = drow.gcd(dcol)
  drow /= gcd
  dcol /= gcd

  hit = nil

  while hit.nil? && row >= 0 && col >= 0 && row < map.length && col < map.first.length
    if map[row][col]
      hit = [row, col]
    end

    row += drow
    col += dcol
  end

  hit
end

def normalize_vector(drow, dcol)
  gcd = drow.gcd(dcol)
  drow /= gcd
  dcol /= gcd

  [drow, dcol]
end

map = []

while s = gets
  s.chomp!
  map << s.chars.map { |c| c == "#" }
end

visibilities = []

map.length.times do |row|
  visibilities[row] = []

  map[row].length.times do |col|
    visibilities[row][col] = 0

    if map[row][col]
      visibilities[row][col] = calculate_visibilities(map, row, col)
    end
  end
end

puts "map"

map.each do |row|
  puts(row.map do |col|
    col ? "#" : "."
  end.join(" "))
end

puts

puts "visibilities"

visibilities.each do |row|
  puts(row.map do |col|
    col == 0 ? "." : col
  end.join(" "))
end

max = 0
maxrow = nil
maxcol = nil

visibilities.each_with_index do |row, j|
  row.each_with_index do |col, i|
    if col > max
      max = col
      maxrow = j
      maxcol = i
    end
  end
end

puts "max: #{max} (#{maxcol}, #{maxrow})"

nhits = 0
map[maxrow][maxcol] = false

drows = map.length.times.map { |drow| drow-maxrow }
dcols = map.first.length.times.map { |dcol| dcol-maxcol }
vectors = []
drows.each do |drow|
  dcols.each do |dcol|
    vectors << normalize_vector(drow, dcol) unless drow == 0 && dcol == 0
  end
end
vectors.uniq!
vectors.sort_by! { |v| Math.atan2(v.first, v.last) }
until vectors.first == [-1, 0]
  vectors.unshift vectors.pop
end

vectors.each do |v|
  hit = laser(map, maxrow, maxcol, v.first, v.last)

  if hit
    nhits += 1
    puts "hit #{nhits} at (#{hit.last}, #{hit.first})"
  end
end
