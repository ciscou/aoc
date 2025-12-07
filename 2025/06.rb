INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = INPUT.map(&:split)
grid[..-2].each { it.map!(&:to_i) }
h = grid.length
w = grid.first.length

part1 = 0

w.times do |col|
  numbers = (h - 1).times.map { |row| grid[row][col] }
  op = grid.last[col]
  part1 += numbers.reduce(op.to_sym)
end

puts part1

grid = INPUT.map(&:chars)
h = grid.length
w = grid.first.length

part2 = 0

numbers = [0]

(w - 1).downto(0).each do |col|
  all_spaces = true

  (h - 1).times do |row|
    next if grid[row][col] == " "

    all_spaces = false

    numbers[-1] *= 10
    numbers[-1] += grid[row][col].to_i
  end
 
  op = grid.last[col]

  if op == " "
    numbers.clear if all_spaces
    numbers << 0
  else
    part2 += numbers.reduce(op.to_sym)
  end
end

puts part2
