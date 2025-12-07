INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = INPUT.map(&:chars)

part1 = 0

stack = []
grid.first.each_with_index { |c, i| stack << [0, i] if c == "S" }

until stack.empty?
  # puts grid.map(&:join)
  # gets

  row, col = stack.shift
  row += 1

  next unless row < grid.length

  case grid[row][col]
  when "."
    grid[row][col] = "|"
    stack << [row, col]
  when "^"
    part1 += 1
    stack << [row, col - 1]
    stack << [row, col + 1]
  when "|"
    # no-op
  else
    raise
  end
end

puts part1
