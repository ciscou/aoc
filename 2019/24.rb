input = <<EOS
#..##
##...
.#.#.
#####
####.
EOS

def bug_at(grid, row, col)
  return 0 if row < 0
  return 0 if col < 0
  return 0 if row > grid.length - 1
  return 0 if col > grid.first.length - 1

  grid[row][col] ? 1 : 0
end

def count_adj_bugs(grid, row, col)
  bug_at(grid, row-1, col) +
  bug_at(grid, row+1, col) +
  bug_at(grid, row, col-1) +
  bug_at(grid, row, col+1)
end

def biodiversity(grid)
  weight = 1
  sum = 0

  grid.each do |row|
    row.each do |col|
      sum += weight if col

      weight *= 2
    end
  end

  sum
end

grid = input.lines.map do |line|
  line.chomp.split(//).map { |c| c == "#" }
end

seen_grids = []

until seen_grids.include?(grid)
  seen_grids << grid

  new_grid = []
  grid.length.times do |row|
    new_grid << []
    grid.first.length.times do |col|
      new_grid[row][col] = grid[row][col]

      if grid[row][col]
        new_grid[row][col] = false unless count_adj_bugs(grid, row, col) == 1
      else
        new_grid[row][col] = true if [1, 2].include? count_adj_bugs(grid, row, col)
      end
    end
  end

  puts
  puts "grid"
  puts

  grid.each do |row|
    puts row.map { |c| c ? "#" : "." }.join(" ")
  end

  puts
  puts "new_grid"
  puts

  new_grid.each do |row|
    puts row.map { |c| c ? "#" : "." }.join(" ")
  end

  grid = new_grid
end

puts biodiversity(grid)
