INPUT = <<EOS
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

def part1
  grid = INPUT.lines.map do |line|
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

    grid = new_grid
  end

  biodiversity(grid)
end

class InfiniteGrid
  def initialize(cells, parent = nil)
    @cells = cells
    @parent = parent

    @cells[3][3] = nil
  end

  def evolve
    new_cells = []

    @cells.length.times do |row|
      new_cells << []

      @cells.first.length.times do |col|
        new_cells[row][col] = cells[row][col]

        if row == 3 && col == 3
          @child.evolve unless @child.nil?
        elsif @cells[row][col]
          new_cells[row][col] = false unless count_adj_bugs(row, col) == 1
        else
          new_cells[row][col] = true if [1, 2].include? count_adj_bugs(row, col)
        end
      end
    end

    @cells = new_cells
  end

  def bug_at(row, col, from_row, from_col)
    return 0 if row < 0
    return 0 if col < 0
    return 0 if row > @cells.length - 1
    return 0 if col > @cells.first.length - 1

    @cells[row][col] ? 1 : 0
  end

  def count_adj_bugs(row, col)
    bug_at(row-1, col, row, col) +
    bug_at(row+1, col, row, col) +
    bug_at(row, col-1, row, col) +
    bug_at(row, col+1, row, col)
  end

  def neightbours(row, col)

  end

  def count_bugs
    raise "TODO"
  end
end

def part2
  cells = INPUT.lines.map do |line|
    line.chomp.split(//).map { |c| c == "#" }
  end

  grid = InfiniteGrid.new(cells)

  200.times do
    grid.evolve
  end

  grid.count_bugs
end

puts part1
puts part2
