INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Grid
  def initialize(cells: {}, infinite: false, parent: nil, child: nil)
    @cells = cells
    @infinite = infinite
    @parent = parent
    @child = child

    @height = 5
    @width = 5
  end

  def evolve_until_repeat
    seen_grids = []

    until seen_grids.include?(@cells)
      seen_grids << @cells

      evolve
    end
  end

  def biodiversity
    weight = 1
    sum = 0

    @height.times do |row|
      @width.times do |col|
        sum += weight if @cells[[row, col]]

        weight *= 2
      end
    end

    sum
  end

  def evolve
    new_cells = evolve_self

    if @infinite
      @child ||= Grid.new(infinite: true, parent: self)
      @child.evolve_child

      @parent ||= Grid.new(infinite: true, child: self)
      @parent.evolve_parent
    end

    @cells = new_cells
  end

  def evolve_child
    new_cells = evolve_self

    @child.evolve_child unless @child.nil?
    @child ||= Grid.new(infinite: true, parent: self)

    @cells = new_cells
  end

  def evolve_parent
    new_cells = evolve_self

    @parent.evolve_parent unless @parent.nil?
    @parent ||= Grid.new(infinite: true, child: self)

    @cells = new_cells
  end

  def evolve_self
    new_cells = {}

    @height.times do |row|
      @width.times do |col|
        new_cells[[row, col]] = @cells[[row, col]]

        next if @infinite && row == 2 && col == 2

        if @cells[[row, col]]
          new_cells[[row, col]] = false unless count_adj_bugs(row, col) == 1
        else
          new_cells[[row, col]] = true if [1, 2].include? count_adj_bugs(row, col)
        end
      end
    end

    new_cells
  end

  def bug_at(row, col)
    return 0 if @infinite && row == 2 && col == 2

    @cells[[row, col]] ? 1 : 0
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
      if @infinite && row == 2 && col == 2
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
    bugs = 0
    bugs += count_self_bugs
    bugs += @child.count_child_bugs unless @child.nil?
    bugs += @parent.count_parent_bugs unless @parent.nil?
  end

  def count_self_bugs
    @height.times.sum do |row|
      @width.times.sum do |col|
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
    @height.times.each do |row|
      line = @width.times.map do |col|
        if @infinite && row == 2 && col == 2
          "?"
        elsif @cells[[row, col]]
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

def part1
  cells = {}

  5.times do |row|
    5.times do |col|
      cells[[row, col]] = true if INPUT[row][col] == "#"
    end
  end

  grid = Grid.new(cells: cells)
  grid.evolve_until_repeat

  grid.biodiversity
end

def part2
  cells = {}

  5.times do |row|
    5.times do |col|
      cells[[row, col]] = true if INPUT[row][col] == "#"
    end
  end

  grid = Grid.new(cells: cells, infinite: true)

  200.times do |i|
    grid.evolve
  end

  grid.count_bugs
end

puts part1
puts part2
