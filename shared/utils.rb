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

class Dijkstra
  def execute
    pq = PriorityQueue.new
    pq.push(state: initial_state, priority: priority(initial_state))

    Enumerator.new do |y|
      loop do
        node = pq.pop
        break if node.nil?

        state = node[:state]

        next if visited?(state)

        y << state

        neighbours(state).each do |next_state|
          pq.push(state: next_state, priority: priority(next_state))
        end
      end
    end
  end
end

class BFS
  def execute
    q = []
    q.push(initial_state)

    Enumerator.new do |y|
      until q.empty?
        state = q.shift

        next if visited?(state)

        y << state

        neighbours(state).each do |next_state|
          q.push(next_state)
        end
      end
    end
  end
end

class GridBFS < BFS
  def initialize(grid, start_row, start_col)
    @grid = grid
    @start_row = start_row
    @start_col = start_col

    @v = Set.new
  end

  private

  def initial_state
    [@start_row, @start_col, []]
  end

  def neighbours(state)
    row, col, path = state

    ns = []

    ns << [row - 1, col, path + [[row - 1, col]]]
    ns << [row + 1, col, path + [[row + 1, col]]]
    ns << [row, col - 1, path + [[row, col - 1]]]
    ns << [row, col + 1, path + [[row, col + 1]]]

    ns.select do |row, col, _path|
      next false if row < 0
      next false if col < 0
      next false unless row < @grid.length
      next false unless col < @grid[row].length

      next false if @grid[row][col] == "#"

      true
    end
  end

  def visited?(state)
    row, col, _path = state

    if @v.add?([row, col])
      false
    else
      true
    end
  end
end
