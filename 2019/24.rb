INPUT = File.read(__FILE__.sub('.rb', '_example.txt')).lines.map(&:chomp)

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
  grid = INPUT.map do |line|
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
  def initialize(parent: nil, child: nil)
    @cells = INPUT.map do |line|
      line.chomp.split(//).map { |c| c == "#" }
    end

    @parent = parent
    @child = child

    @cells[2][2] = nil # TODO: ???
  end

  attr_reader :parent, :child

  def evolve
    evolve_self

    @child.evolve_child unless @child.nil?
    @child ||= InfiniteGrid.new(parent: self)

    @parent.evolve_parent unless @parent.nil?
    @parent ||= InfiniteGrid.new(child: self)
  end

  def evolve_child
    evolve_self

    @child.evolve_child unless @child.nil?
    @child ||= InfiniteGrid.new(parent: self)
  end

  def evolve_parent
    evolve_self

    @parent.evolve_parent unless @parent.nil?
    @parent ||= InfiniteGrid.new(child: self)
  end

  def evolve_self
    new_cells = []

    @cells.length.times do |row|
      new_cells << []

      @cells.first.length.times do |col|
        new_cells[row][col] = @cells[row][col]

        next if row == 2 && col == 2

        if @cells[row][col]
          new_cells[row][col] = false unless count_adj_bugs(row, col) == 1
        else
          new_cells[row][col] = true if [1, 2].include? count_adj_bugs(row, col)
        end
      end
    end

    @cells = new_cells
  end

  def bug_at(row, col)
    @cells[row][col] ? 1 : 0
  end

  def count_adj_bugs(row, col)
    bugs = 0
    bugs += self_neighbours(row, col).sum { |row, col| bug_at(row, col) }
    bugs += parent_neighbours(row, col).sum { |row, col| @parent.bug_at(row, col) } unless @parent.nil?
    bugs += child_neighbours(row, col).sum { |row, col| @child.bug_at(row, col) } unless @child.nil?

    bugs
  end

  def self_neighbours(row, col)
    [
      [ 1,  0],
      [ 0,  1],
      [-1,  0],
      [ 0, -1]
    ].map do |drow, dcol|
      [row + drow, col + dcol]
    end.select do |row, col|
      if row == 2 && col == 2
        false
      else
        row >= 0 && col >= 0 && row < 5 && col < 5
      end
    end
  end

  def child_neighbours(row, col)
    case [row, col]
    when [2, 1] then 5.times.map { |i| [i, 0] }
    when [2, 3] then 5.times.map { |i| [i, 4] }
    when [1, 2] then 5.times.map { |i| [0, i] }
    when [3, 2] then 5.times.map { |i| [4, i] }
    else []
    end
  end

  def parent_neighbours(row, col)
    left_right = case col
                 when 0 then [[2, 1]]
                 when 4 then [[2, 3]]
                 else []
                 end

    top_bottom = case row
                 when 0 then [[1, 2]]
                 when 4 then [[3, 2]]
                 else []
                 end

    left_right + top_bottom
  end

  def count_bugs
    count_self_bugs + count_child_bugs + count_parent_bugs
  end

  def count_self_bugs
    5.times.sum do |row|
      5.times.sum do |col|
        bug_at(row, col)
      end
    end
  end

  def count_child_bugs
    bugs = count_self_bugs
    bugs += @child.count_child_bugs unless @child.nil?

    bugs
  end

  def count_parent_bugs
    bugs = count_self_bugs
    bugs += @parent.count_parent_bugs unless @parent.nil?

    bugs
  end

  def draw
    5.times.each do |row|
      line = 5.times.map do |col|
        if row == 2 && col == 2
          "?"
        elsif @cells[row][col]
          "#"
        else
          "."
        end
      end

      puts line.join("")
    end

    puts
  end
end

def part2
  grid = InfiniteGrid.new()

  10.times do
    grid.evolve
  end

  grid.parent.parent.parent.parent.parent.draw
  grid.parent.parent.parent.parent.draw
  grid.parent.parent.parent.draw
  grid.parent.parent.draw
  grid.parent.draw
  puts "Depth 0"
  puts
  grid.draw
  grid.child.draw
  grid.child.child.draw
  grid.child.child.child.draw
  grid.child.child.child.child.draw
  grid.child.child.child.child.child.draw

  grid.count_bugs
end

puts part1
puts part2
