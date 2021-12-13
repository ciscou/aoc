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
    @robots = []
    @cells = INPUT.map(&:chars)

    @available_keys = {}

    @cells.length.times do |row|
      @cells.first.length.times do |col|
        pos = [row, col]

        @available_keys[cell_at(pos)] = pos if is_key?(pos)
        @robots << pos if is_robot?(pos)
      end
    end
  end

  def cell_at(pos)
    row, col = pos

    @cells[row][col]
  end

  def cells_at(path)
    path.map { |pos| cell_at(pos) }
  end

  def robots_count
    @robots.length
  end

  def available_keys
    @available_keys.keys
  end

  def key_position(key)
    @available_keys[key]
  end

  def robot_position(index)
    @robots[index]
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
      row >= @cells.length ||
      col >= @cells.first.length
    end
  end

  def calculate_all_paths!(start)
    @calculated_paths ||= Hash.new { |h, k| h[k] = [] }

    do_calculate_all_paths!(start, start, [start], start => true)
  end

  def calculated_paths(from, to)
    @calculated_paths[[from, to]]
  end

  def find_min_path_to_all_keys
    # Dijkstra

    pq = PriorityQueue.new
    pq.push(number: 3, priority: 3)
    pq.push(number: 4, priority: 4)
    pq.push(number: -27, priority: -27)
    pq.push(number: 0, priority: 0)

    distances = Hash.new(999_999_999_999)
    parents = {}
    visited = {}

    initial_state = [robots_count.times.map { |i| robot_position(i) }, {}]

    distances[initial_state] = 0

    pq = PriorityQueue.new
    pq.push(state: initial_state, priority: 0)

    loop do
      node = pq.pop

      break unless node

      state = node[:state]

      visited[state] = true

      robots, keys = node[:state]

      return [node, distances, parents] if keys.size == available_keys.size

      robots_count.times do |index|
        pos = robots[index]

        remaining_keys = available_keys - keys.keys

        remaining_keys.each do |remaining_key|
          calculated_paths(pos, key_position(remaining_key)).each do |path|
            next_keys = keys.dup

            closed_door = false

            path.each do |pos|
              next_keys[cell_at(pos)] = true if is_key?(pos)
              closed_door = true if is_door?(pos) && !next_keys[key_for(cell_at(pos))]
            end

            next if closed_door

            next_row, next_col = path.last

            next_robots = robots.dup
            next_robots[index] = [next_row, next_col]

            next_state = [next_robots, next_keys]

            next if visited[next_state]

            if distances[next_state] > distances[state] + path.length - 1
              distances[next_state] = distances[state] + path.length - 1
              parents[next_state] = state

              pq.push(state: next_state, priority: -distances[next_state])
            end
          end
        end
      end
    end

    nil
  end

  private

  def do_calculate_all_paths!(start, from, path, visited)
    # DFS w/o early returns so that we exhaust all possibilities

    if start != from && is_key?(from)
      @calculated_paths[[start, from]] << path.dup
    end

    neighbours(from).each do |neighbour|
      next if visited[neighbour]
      next if is_wall?(neighbour)

      visited[neighbour] = true
      path.push(neighbour)

      do_calculate_all_paths!(start, neighbour, path, visited)

      visited.delete(neighbour)
      path.pop
    end
  end

  def key_for(door)
    door.downcase
  end

  def is_key?(pos)
    ("a".."z").include?(cell_at(pos))
  end

  def is_door?(pos)
    ("A".."Z").include?(cell_at(pos))
  end

  def is_robot?(pos)
    cell_at(pos) == "@"
  end

  def is_wall?(pos)
    cell_at(pos) == "#"
  end
end

def part1
  maze1 = Maze.new

  maze1.available_keys.each do |key|
    maze1.calculate_all_paths!(maze1.key_position(key))
  end

  maze1.robots_count.times do |index|
    maze1.calculate_all_paths!(maze1.robot_position(index))
  end

  node, distances, parents = maze1.find_min_path_to_all_keys

  path = []
  state = node[:state]

  while state
    robots = state.first

    robots.each do |robot|
      path.unshift robot
    end

    state = parents[state]
  end

  puts maze1.cells_at(path).join(" ")

  node[:priority] * -1
end

puts part1
