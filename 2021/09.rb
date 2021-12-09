INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Grid
  def initialize(cells)
    @cells = cells
    @height = cells.length
    @width = cells.first.length
  end

  def neightbours_positions(row, col)
    [
      [row-1, col],
      [row+1, col],
      [row, col-1],
      [row, col+1]
    ].select do |row, col|
      row >= 0 && col >= 0 && row < @height && col < @width
    end
  end

  def neightbours(row, col)
    neightbours_positions(row, col).map { |row, col| @cells[row][col] }
  end

  def low_points_positions
    res = []

    @height.times do |row|
      @width.times do |col|
        res << [row, col] if neightbours(row, col).all? { |n| n > @cells[row][col] }
      end
    end

    res
  end

  def low_points
    low_points_positions.map { |row, col| @cells[row][col] }
  end

  def low_points_risk_level
    low_points.map { |lp| lp + 1 }
  end

  def basin_size(row, col)
    basin_size_helper(row, col, {})
  end

  def three_largest_basin_sizes
    low_points_positions.map { |row, col| basin_size(row, col) }.sort.last(3)
  end

  private

  def basin_size_helper(row, col, visited)
    return 0 if @cells[row][col] == 9
    return 0 if visited[[row, col]]

    visited[[row, col]] = true

    return 1 + neightbours_positions(row, col).sum { |row, col| basin_size_helper(row, col, visited) }
  end
end

grid = Grid.new(INPUT.map { |line| line.chars.map(&:to_i) })

puts grid.low_points_risk_level.sum
puts grid.three_largest_basin_sizes.inject(:*)
