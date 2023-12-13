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

  def row(r)
    ncols.times.map { @cells[[r, _1]] }
  end

  def col(c)
    nrows.times.map { @cells[[_1, c]] }
  end

  attr_reader :nrows, :ncols
end

grids = INPUT.chunk { _1.empty? && nil }.map(&:last).map do |lines|
  Grid.new(lines)
end

part1 = 0
grids.each do |grid|
  (1..(grid.ncols - 1)).each do |col|
    next unless col.times.all? do |c|
      mirror = col + col - c - 1

      next true unless mirror < grid.ncols
      grid.col(c) == grid.col(mirror)
    end

    part1 += col
  end

  (1..(grid.nrows - 1)).each do |row|
    next unless row.times.all? do |r|
      mirror = row + row - r - 1

      next true unless mirror < grid.nrows
      grid.row(r) == grid.row(mirror)
    end

    part1 += row * 100
  end
end
puts part1
