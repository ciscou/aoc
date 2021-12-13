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
    pq = PriorityQueue.new

    @robots.each do |pos|
      row, col = pos
      pq.push(state: [row, col, {}], cost: 0, priority: 0)
    end

    loop do
      node = pq.pop
      next unless node

      row, col, keys = node[:state]
      cost = node[:cost]
      pos = [row, col]

      remaining_keys = available_keys - keys.keys

      return node if remaining_keys.empty?

      remaining_keys.each do |remaining_key|
        calculated_paths(pos, key_position(remaining_key)).each do |path|
          path_doors = cells_at(path.select { |cell| is_door? cell })

          # TODO what if I'll get the key in the middle of the path, right before the door?
          # maybe loop through the path and collect keys as you go
          next if path_doors.any? { |door| !keys[key_for(door)] }

          path_keys = cells_at(path.select { |cell| is_key? cell })

          next_row, next_col = path.last

          next_keys = keys.dup
          path_keys.each do |key|
            next_keys[key] = true
          end

          next_cost = cost + path.length - 1

          pq.push(state: [next_row, next_col, next_keys], cost: next_cost, priority: -next_cost)
        end
      end
    end
  end

  private

  def do_calculate_all_paths!(start, from, path, visited)
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

maze1 = Maze.new

maze1.available_keys.each do |key|
  maze1.calculate_all_paths!(maze1.key_position(key))
end

maze1.robots_count.times do |index|
  maze1.calculate_all_paths!(maze1.robot_position(index))
end

maze1.calculated_paths(maze1.robot_position(0), maze1.key_position("a")).each do |path|
  puts maze1.cells_at(path).join("")
end

puts maze1.find_min_path_to_all_keys.inspect

# maze2 = Maze.new
# maze2.four_robots!
# puts maze2.calculate_path_to_collect_all_keys
