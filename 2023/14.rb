INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Grid
  def initialize(lines)
    @cells = {}
    lines.each_with_index do |line, row|
      line.chars.each_with_index do |char, col|
        @cells[[row, col]] = char
      end
    end
    @nrows = @cells.keys.map(&:first).max + 1
    @ncols = @cells.keys.map(&:last).max + 1
  end

  attr_reader :nrows, :ncols, :cells

  def tilt_north!
    nrows.times do |row|
      ncols.times do |col|
        next unless @cells[[row, col]] == "."
        next_o = (row..nrows).detect { cell = @cells[[_1, col]] ; break if cell == "#" ; cell == "O" }
        next unless next_o
        @cells[[row, col]] = "O"
        @cells[[next_o, col]] = "."
      end
    end
  end

  def tilt_west!
    ncols.times do |col|
      nrows.times do |row|
        next unless @cells[[row, col]] == "."
        next_o = (col..ncols).detect { cell = @cells[[row, _1]] ; break if cell == "#" ; cell == "O" }
        next unless next_o
        @cells[[row, col]] = "O"
        @cells[[row, next_o]] = "."
      end
    end
  end

  def tilt_south!
    (nrows - 1).downto(0) do |row|
      ncols.times do |col|
        next unless @cells[[row, col]] == "."
        next_o = row.downto(0).detect { cell = @cells[[_1, col]] ; break if cell == "#" ; cell == "O" }
        next unless next_o
        @cells[[row, col]] = "O"
        @cells[[next_o, col]] = "."
      end
    end
  end

  def tilt_east!
    (ncols - 1).downto(0) do |col|
      nrows.times do |row|
        next unless @cells[[row, col]] == "."
        next_o = col.downto(0).detect { cell = @cells[[row, _1]] ; break if cell == "#" ; cell == "O" }
        next unless next_o
        @cells[[row, col]] = "O"
        @cells[[row, next_o]] = "."
      end
    end
  end

  def north_support_load
    res = 0
    nrows.times do |row|
      ncols.times do |col|
        if @cells[[row, col]] == "O"
          res += (nrows - row)
        end
      end
    end
    res
  end

  def display
    nrows.times do |row|
      ncols.times do |col|
        print @cells[[row, col]]
      end
      puts
    end
  end

  def tilt_cycle!
    tilt_north!
    tilt_west!
    tilt_south!
    tilt_east!
  end
end

grid = Grid.new(INPUT)
seen = {}
cycles = 0
until seen[grid.cells]
  seen[grid.cells] = cycles
  grid.tilt_cycle!
  cycles += 1
end
puts seen[grid.cells]
puts cycles

need = 1_000_000_000
need -= seen[grid.cells]
p [seen[grid.cells], need, cycles]
need = seen[grid.cells] + need % (cycles - seen[grid.cells])
puts need

grid = Grid.new(INPUT)
need.times { grid.tilt_cycle! }
puts grid.north_support_load
