SOURCE = "109,424,203,1,21101,11,0,0,1105,1,282,21102,18,1,0,1105,1,259,2102,1,1,221,203,1,21102,1,31,0,1106,0,282,21101,38,0,0,1105,1,259,21001,23,0,2,21201,1,0,3,21101,0,1,1,21101,0,57,0,1105,1,303,1201,1,0,222,20102,1,221,3,20101,0,221,2,21101,259,0,1,21102,80,1,0,1106,0,225,21101,127,0,2,21102,91,1,0,1106,0,303,1201,1,0,223,20102,1,222,4,21101,259,0,3,21101,0,225,2,21102,225,1,1,21102,1,118,0,1106,0,225,21001,222,0,3,21101,0,89,2,21101,133,0,0,1105,1,303,21202,1,-1,1,22001,223,1,1,21101,0,148,0,1105,1,259,2102,1,1,223,21002,221,1,4,21001,222,0,3,21101,0,21,2,1001,132,-2,224,1002,224,2,224,1001,224,3,224,1002,132,-1,132,1,224,132,224,21001,224,1,1,21102,195,1,0,106,0,108,20207,1,223,2,20102,1,23,1,21102,1,-1,3,21101,0,214,0,1105,1,303,22101,1,1,1,204,1,99,0,0,0,0,109,5,1201,-4,0,249,22102,1,-3,1,21201,-2,0,2,22101,0,-1,3,21102,250,1,0,1105,1,225,21202,1,1,-4,109,-5,2105,1,0,109,3,22107,0,-2,-1,21202,-1,2,-1,21201,-1,-1,-1,22202,-1,-2,-2,109,-3,2106,0,0,109,3,21207,-2,0,-1,1206,-1,294,104,0,99,22101,0,-2,-2,109,-3,2106,0,0,109,5,22207,-3,-4,-1,1206,-1,346,22201,-4,-3,-4,21202,-3,-1,-1,22201,-4,-1,2,21202,2,-1,-1,22201,-4,-1,1,21201,-2,0,3,21101,0,343,0,1106,0,303,1105,1,415,22207,-2,-3,-1,1206,-1,387,22201,-3,-2,-3,21202,-2,-1,-1,22201,-3,-1,3,21202,3,-1,-1,22201,-3,-1,2,22101,0,-4,1,21101,384,0,0,1106,0,303,1105,1,415,21202,-4,-1,-4,22201,-4,-3,-4,22202,-3,-2,-2,22202,-2,-4,-4,22202,-3,-2,-3,21202,-4,-1,-2,22201,-3,-2,1,21201,1,0,-4,109,-5,2105,1,0"

def load_grid(height, width, offset_row, offset_col)
  grid = {}

height.times do |row|
width.times do |col|

row_given = false

program = {}
SOURCE.split(",").map(&:to_i).each_with_index do |x, i|
  program[i] = x
end
program.default = 0

pc = 0
relative_base = 0

until program[pc] == 99
  o, x, y, z = 4.times.map { |i| program[pc + i] }

  case o % 100
  when 1
    abc = o / 100
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)
    x = program[x] if c == 0
    x = program[x+relative_base] if c == 2
    y = program[y] if b == 0
    y = program[y+relative_base] if b == 2
    z = z + relative_base if a == 2
    program[z] = x + y
    pc += 4
  when 2
    abc = o / 100
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)
    x = program[x] if c == 0
    x = program[x+relative_base] if c == 2
    y = program[y] if b == 0
    y = program[y+relative_base] if b == 2
    z = z + relative_base if a == 2
    program[z] = x * y
    pc += 4
  when 3
    abc = o / 100
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)
    x = x+relative_base if c == 2
    if row_given
      program[x] = row + offset_row
    else
      program[x] = col + offset_col
      row_given = true
    end
    pc += 2
  when 4
    abc = o / 100
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)
    x = program[x] if c == 0
    x = program[x+relative_base] if c == 2
    y = program[y] if b == 0
    y = program[y+relative_base] if b == 2
    grid[[row, col]] = x
    pc += 2
  when 5
    abc = o / 100
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)
    x = program[x] if c == 0
    x = program[x+relative_base] if c == 2
    y = program[y] if b == 0
    y = program[y+relative_base] if b == 2
    if x == 0
      pc += 3
    else
      pc = y
    end
  when 6
    abc = o / 100
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)
    x = program[x] if c == 0
    x = program[x+relative_base] if c == 2
    y = program[y] if b == 0
    y = program[y+relative_base] if b == 2
    if x == 0
      pc = y
    else
      pc += 3
    end
  when 7
    abc = o / 100
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)
    x = program[x] if c == 0
    x = program[x+relative_base] if c == 2
    y = program[y] if b == 0
    y = program[y+relative_base] if b == 2
    z = z + relative_base if a == 2
    if x < y
      program[z] = 1
    else
      program[z] = 0
    end
    pc += 4
  when 8
    abc = o / 100
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)
    x = program[x] if c == 0
    x = program[x+relative_base] if c == 2
    y = program[y] if b == 0
    y = program[y+relative_base] if b == 2
    z = z + relative_base if a == 2
    if x == y
      program[z] = 1
    else
      program[z] = 0
    end
    pc += 4
  when 9
    abc = o / 100
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)
    x = program[x] if c == 0
    x = program[x+relative_base] if c == 2
    y = program[y] if b == 0
    y = program[y+relative_base] if b == 2
    relative_base += x
    pc += 2
  when 99
    # halt: no-op
  else
    raise "OMG"
  end
end
end
end

  grid
end

grid = load_grid(50, 50, 0, 0)

puts grid.values.select { |v| v == 1 }.length

ro, co = 1060, 880

grid = load_grid(120, 120, ro, co)
120.times do |row|
  puts 120.times.map { |col| grid[[row, col]] }.join("")
end

points = []
120.times do |row|
  120.times do |col|
    if grid[[row, col]] == 1 && grid[[row+100, col]] == 1 && grid[[row, col+100]] == 1 && grid[[row+100, col+100]]
      points << [row + ro, col + co]
    end
  end
end
points.sort_by!(&:sum)
puts points.map(&:inspect)
point = points.first

puts point.first + point.last * 10_000
puts point.first * 10_000 + point.last

# puts [ro, co].join(" ")

# while s = gets
#   ro, co = s.chomp.split(" ").map(&:to_i)

#   grid = load_grid(200, 200, ro, co)
#   200.times do |row|
#     puts 200.times.map { |col| grid[[row, col]] }.join("")
#   end

#   puts [ro, co].join(" ")
# end
