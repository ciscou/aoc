INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

# stolen from https://gist.github.com/brianstorti/e20300eb2e7d62b87849
class PriorityQueue
  attr_reader :elements

  def initialize
    @elements = [nil]
  end

  def <<(element)
    @elements << element
    bubble_up(@elements.size - 1)
  end

  alias_method :push, :<<

  def pop
    exchange(1, @elements.size - 1)
    max = @elements.pop
    bubble_down(1)
    max
  end

  private

  def bubble_up(index)
    parent_index = (index / 2)

    return if index <= 1
    return if @elements[parent_index][:priority] >= @elements[index][:priority]

    exchange(index, parent_index)
    bubble_up(parent_index)
  end

  def bubble_down(index)
    child_index = (index * 2)

    return if child_index > @elements.size - 1

    not_the_last_element = child_index < @elements.size - 1
    left_element = @elements[child_index]
    right_element = @elements[child_index + 1]
    child_index += 1 if not_the_last_element && right_element[:priority] > left_element[:priority]

    return if @elements[index][:priority] >= @elements[child_index][:priority]

    exchange(index, child_index)
    bubble_down(child_index)
  end

  def exchange(source, target)
    @elements[source], @elements[target] = @elements[target], @elements[source]
  end
end

class Maze
  def initialize
    @cells = INPUT.map { |line| line.chars.map(&:to_i) }
    @height = @cells.length
    @width = @cells.first.length
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

  def neighbours(pos)
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
    end
  end

  def find_min_risk_path
    pq = PriorityQueue.new
    visited = {}

    pq.push(position: [0, 0], total_risk: 0, priority: 0)
    # visited[[0, 0]] = true # Do not mark 0, 0 as visited as we might to enter it later

    loop do
      node = pq.pop
      break if node.nil?

      position = node[:position]
      total_risk = node[:total_risk]

      if position == [@height - 1, @width - 1]
        return total_risk
      end

      neighbours(position).each do |neighbour|
        next if visited[neighbour]

        visited[neighbour] = true

        risk = cell_at(neighbour)

        pq.push(position: neighbour, total_risk: total_risk + risk, priority: -total_risk - risk)
      end
    end

    nil
  end
end

maze = Maze.new
puts maze.find_min_risk_path

maze.expand!
puts maze.find_min_risk_path
