input = 3999

grid = []
300.times do |x|
  grid[x] = []

  300.times do |y|
    rack_id = x + 1 + 10
    power = rack_id
    power *= y + 1
    power += input
    power *= rack_id
    power = power % 1000 / 100
    power -= 5

    grid[x][y] = power
  end
end

10.times do |x|
  p 10.times.map { |y| grid[x][y] }
end

summed_area_table = 300.times.map { [] }

puts
puts
puts
10.times do |x|
  p 10.times.map { |y| summed_area_table[x][y] }
end

300.times do |x|
  300.times do |y|
    value = grid[x][y]
    value += summed_area_table[x-1][y] if x > 0
    value += summed_area_table[x][y-1] if y > 0
    value -= summed_area_table[x-1][y-1] if x > 0 && y > 0

    summed_area_table[x][y] = value
  end
end

puts
puts
puts
10.times do |x|
  p 10.times.map { |y| summed_area_table[x][y] }
end

best_power = -999_999_999_999
best_x = nil
best_y = nil
best_size = nil

[3].each do |size|
  puts size

  (300-size).times do |x|
    (300-size).times do |y|
      power = 0

      power += summed_area_table[x+size][y+size]
      power += summed_area_table[x][y]
      power -= summed_area_table[x+size][y]
      power -= summed_area_table[x][y+size]

      if power > best_power
        best_power = power
        best_x = x
        best_y = y
        best_size = size
      end
    end
  end
end

puts [best_x + 1, best_y + 1, best_size].join(",")
