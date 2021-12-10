INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

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
    @cells = INPUT.map(&:chars)

    @available_keys = {}

    @cells.length.times do |row|
      @cells.first.length.times do |col|
        cell = @cells[row][col]
        @available_keys[cell] = [row, col] if ("a".."z").include?(cell)
        if cell == "@"
          @robot = [row, col]
          @cells[row][col] = "."
        end
      end
    end

    @collected_keys = []

    @cached_paths = {}
  end

  attr_reader :robot, :available_keys

  def move(robot, drow, dcol)
    robot[0] += drow
    robot[1] += dcol
  end

  def valid_position?(robot)
    return false if robot[0] < 0
    return false if robot[1] < 0
    return false if robot[0] >= @cells.length
    return false if robot[1] >= @cells.first.length

    cell = cell(robot)

    return false if cell == "#"
    return false if ("A".."Z").include?(cell) && !@collected_keys.include?(cell.downcase)

    true
  end

  def cell(robot)
    @cells[robot[0]][robot[1]]
  end

  def collect_key!(robot)
    cell = cell(robot)
    if ("a".."z").include?(cell) && !@collected_keys.include?(cell)
      @collected_keys << cell
      cell
    end
  end

  def all_keys_collected?
    remaining_keys.empty?
  end

  def remaining_keys
    @available_keys.keys - @collected_keys
  end

  def calculate_path(from)
    cache_key = [from, @collected_keys].inspect
    if @cached_paths.key?(cache_key)
      return @cached_paths[cache_key]
    end

    res = {}

    queue = []
    visited = {}

    queue.push([from[0], from[1], 0])
    visited[[from[0], from[1]]] = true

    until queue.empty?
      row, col, moves = queue.shift
      robot = [row, col]

      cell = cell(robot)
      if ("a".."z").include?(cell)
        res[cell] = moves
      end

      [
        [ 0, -1],
        [ 1,  0],
        [ 0,  1],
        [-1,  0]
      ].each do |drow, dcol|
        move(robot, drow, dcol)

        if !visited[[robot[0], robot[1]]] && valid_position?(robot)
          visited[[robot[0], robot[1]]] = true
          queue.push([robot[0], robot[1], moves + 1])
        end

        move(robot, -drow, -dcol)
      end
    end

    @cached_paths[cache_key] = res
    res
  end

  def calculate_path_to_collect_all_keys
    from = [robot[0], robot[1]]

    pq = PriorityQueue.new
    visited = Hash.new(Float::INFINITY)

    pq.push(state: [from[0], from[1], "", 0], priority: 0)
    visited[[from[0], from[1], ""]] = 0

    loop do
      node = pq.pop
      break if node.nil?

      row, col, collected_keys, total_moves = node[:state]
      from = [row, col]

      @collected_keys = collected_keys.split("")

      if all_keys_collected?
        puts "found solution with #{total_moves} moves"
        return total_moves
      end

      distances = calculate_path(from)
      candidates = remaining_keys.map { |k| [k, distances[k]] }
      candidates.reject! { |c| c.last.nil? }

      candidates.each do |candidate|
        key, moves = candidate
        pos = available_keys[key]
        total_moves += moves

        @collected_keys << key

        if total_moves < visited[[pos[0], pos[1], @collected_keys.sort.join("")]]
          visited[[pos[0], pos[1], @collected_keys.sort.join("")]] = total_moves
          pq.push(state: [pos[0], pos[1], @collected_keys.sort.join(""), total_moves], priority: -total_moves * @available_keys.length - @collected_keys.length)
        end

        @collected_keys.delete(key)
        total_moves -= moves
      end
    end
  end

  def inspect
    @cells.length.times.map do |row|
      @cells[row].length.times.map do |col|
        cell = @cells[row][col]
        if @robot == [row, col]
          "@"
        elsif @collected_keys.include?(cell)
          "."
        else
          cell
        end
      end.join("")
    end.join("\n")
  end
end

maze = Maze.new
robot = maze.robot

puts maze.calculate_path_to_collect_all_keys

# maze.available_keys.each do |k, v|
#   puts "calculate path to #{k}"
#   solution = maze.calculate_path(robot, v)
#   if solution
#     puts "  solved in #{solution} moves!"
#   else
#     puts "  no solution found!"
#   end
# end

# while s = gets
#   move = {
#     "a" => [ 0, -1],
#     "s" => [ 1,  0],
#     "d" => [ 0,  1],
#     "w" => [-1,  0]
#   }[s.chomp]

#   if move
#     maze.move(robot, move[0], move[1])
#     if maze.valid_position?(robot)
#       key = maze.collect_key!(robot)
#       if key
#         puts "collected key #{key}!!!"
#         if maze.all_keys_collected?
#           puts "all keys collected!!!"
#         end
#       end
#     else
#       puts "invalid!"
#       maze.move(robot, -move[0], -move[1])
#     end
#   end

#   p maze
# end
