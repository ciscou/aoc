INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = INPUT.map(&:chars)

part1 = 0

stack = []
timelines = grid.map { it.map { 0 } }
grid.first.each_with_index { |c, i| stack << [0, i] if c == "S" }
stack.each { |r, c| timelines[r][c] += 1 }

until stack.empty?
  row, col = stack.shift
  row += 1

  next unless row < grid.length

  case grid[row][col]
  when ".", "|"
    timelines[row][col] = timelines[row-1][col]
    unless grid[row][col] == "|"
      grid[row][col] = "|"
      stack << [row, col]
    end
  when "^"
    part1 += 1
    [col - 1, col + 1].each do |next_col|
      timelines[row][next_col] += timelines[row-1][col]
      unless grid[row][next_col] == "|"
        grid[row][next_col] = "|"
        stack << [row, next_col]
      end
    end
  else
    raise
  end
end

puts part1

part2 = timelines.last.sum

puts part2
