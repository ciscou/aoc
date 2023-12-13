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

  def row_mirror
    (1..(nrows - 1)).each do |row|
      next if row == @row_mirror_was

      next unless row.times.all? do |r|
        mirror = row + row - r - 1

        next true unless mirror < nrows
        row(r) == row(mirror)
      end

      return row
    end

    nil
  end

  def col_mirror
    (1..(ncols - 1)).each do |col|
      next if col == @col_mirror_was

      next unless col.times.all? do |c|
        mirror = col + col - c - 1

        next true unless mirror < ncols
        col(c) == col(mirror)
      end

      return col
    end

    nil
  end

  def toggle!(row, col)
    if @cells[[row, col]] == "#"
      @cells[[row, col]] = "."
    else
      @cells[[row, col]] = "#"
    end
  end

  def find_smudge!
    @row_mirror_was = row_mirror
    @col_mirror_was = col_mirror

    nrows.times do |row|
      ncols.times do |col|
        toggle!(row, col)
        return if row_mirror || col_mirror
        toggle!(row, col)
      end
    end

    raise "uh oh..."
  end

  attr_reader :nrows, :ncols
end

grids = INPUT.chunk { _1.empty? && nil }.map(&:last).map do |lines|
  Grid.new(lines)
end

part1 = 0
grids.each do |grid|
  col = grid.col_mirror
  part1 += col if col

  row = grid.row_mirror
  part1 += row * 100 if row
end
puts part1

grids.each(&:find_smudge!)

part2 = 0
grids.each do |grid|
  col = grid.col_mirror
  part2 += col if col

  row = grid.row_mirror
  part2 += row * 100 if row
end
puts part2
