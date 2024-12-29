require_relative "../shared/utils"

INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Maze < Dijkstra
  def initialize(cells)
    @cells = cells
    @height = @cells.length
    @width = @cells.first.length
    @visited = Set.new
  end

  def expand!
    new_cells = []

    @height.times do |row|
      @width.times do |col|
        5.times.map do |row_offset|
          5.times.map do |col_offset|
            new_risk = @cells[row][col] + row_offset + col_offset
            new_risk -= 9 if new_risk > 9

            new_cells[row + row_offset * @height] ||= []
            new_cells[row + row_offset * @height][col + col_offset * @width] = new_risk
          end
        end
      end
    end

    @cells = new_cells
    @height = @cells.length
    @width = @cells.first.length
  end

  private

  def initial_state
    { position: [0, 0], total_risk: 0 }
  end

  def priority(state)
    -state[:total_risk]
  end

  def visited?(state)
    if @visited.add?(state[:position])
      false
    else
      true
    end
  end

  def draw
    @height.times do |row|
      line = @width.times.map { |col| cell_at([row, col]) }
      puts line.join("")
    end
  end

  def cell_at(pos)
    row, col = pos

    @cells[row][col]
  end

  def cells_at(path)
    path.map { |pos| cell_at(pos) }
  end

  def neighbours(state)
    pos = state[:position]
    row, col = pos

    [
      [-1,  0],
      [ 1,  0],
      [ 0, -1],
      [ 0,  1],
    ].map do |drow, dcol|
      [row + drow, col + dcol]
    end.reject do |row, col|
      row < 0 ||
      col < 0 ||
      row >= @height ||
      col >= @width
    end.map do |pos|
      { position: pos, total_risk: state[:total_risk] + cell_at(pos) }
    end
  end
end

cells = INPUT.map { |line| line.chars.map(&:to_i) }

maze1 = Maze.new(cells)
maze1.execute.each do |state|
  pos = state[:position]
  row, col = pos
  if row == cells.length - 1 && col == cells.first.length - 1
    puts state[:total_risk]
    break
  end
end

maze2 = Maze.new(cells)
maze2.expand!
maze2.execute.each do |state|
  pos = state[:position]
  row, col = pos
  if row == cells.length * 5 - 1 && col == cells.first.length * 5 - 1
    puts state[:total_risk]
    break
  end
end
