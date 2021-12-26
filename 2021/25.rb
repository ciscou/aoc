INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

grid = INPUT.map(&:chars)

height = grid.length
width = grid.first.length

iterations = 0
loop do
  moved = 0

  right_herd = []

  height.times do |row|
    width.times do |col|
      if grid[row][col] == ">"
        right_herd << [row, col]

        right = (col + 1) % width
        if grid[row][right] == "."
          moved += 1
          right_herd.last[1] = right
        end
      end
    end
  end

  height.times do |row|
    width.times do |col|
      grid[row][col] = "." if grid[row][col] == ">"
    end
  end

  right_herd.each do |row, col|
    grid[row][col] = ">"
  end

  down_herd = []

  height.times do |row|
    width.times do |col|
      if grid[row][col] == "v"
        down_herd << [row, col]

        down = (row + 1) % height
        if grid[down][col] == "."
          moved += 1
          down_herd.last[0] = down
        end
      end
    end
  end

  height.times do |row|
    width.times do |col|
      grid[row][col] = "." if grid[row][col] == "v"
    end
  end

  down_herd.each do |row, col|
    grid[row][col] = "v"
  end

  iterations += 1

  break if moved == 0
end

puts iterations
