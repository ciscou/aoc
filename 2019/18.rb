INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

$wasted = 0

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
        cell = @cells[row][col]
        @available_keys[cell] = [row, col] if ("a".."z").include?(cell)
        if cell == "@"
          @robots << [row, col]
        end
      end
    end

    @collected_keys = []

    @cached_paths = {}
  end

  def four_robots!
    robot = @robots.first

    @cells[robot[0]][robot[1]] = "#"
    @cells[robot[0]-1][robot[1]] = "#"
    @cells[robot[0]+1][robot[1]] = "#"
    @cells[robot[0]][robot[1]-1] = "#"
    @cells[robot[0]][robot[1]+1] = "#"

    @robots = [
      [robot[0]-1, robot[1]-1],
      [robot[0]-1, robot[1]+1],
      [robot[0]+1, robot[1]-1],
      [robot[0]+1, robot[1]+1],
    ]

    @robots.each.with_index do |robot, i|
      @cells[robot[0]][robot[1]] = "#{i+1}"
    end
  end

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
    # return false if ("A".."Z").include?(cell) && !@collected_keys.include?(cell.downcase)

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

  def calculate_path(from, keys)
    start = Time.now
    res = _calculate_path(from, keys)
    $wasted += Time.now - start
    res
  end

  def _calculate_path(from, keys)
    # TODO calcula todos los paths posibles desde from hasta todas las demas keys
    # guarda que puertas se atraviesan en cada uno de ellos
    # devuelve el mejor para las llaves que tenemos
    cache_key = [from, keys.sort.join("")]
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
      pos = [row, col]

      cell = cell(pos)
      if keys.include?(cell) # TODO: ??? && !@collected_keys.include?(cell)
        res[cell] = moves
      end

      [
        [ 0, -1],
        [ 1,  0],
        [ 0,  1],
        [-1,  0]
      ].each do |drow, dcol|
        move(pos, drow, dcol)

        cell = cell(pos)
        if ("A".."Z").include?(cell) && keys.include?(cell.downcase)
          # skip, we don't have the key
        else
          if !visited[[pos[0], pos[1]]] && valid_position?(pos)
            visited[[pos[0], pos[1]]] = true
            queue.push([pos[0], pos[1], moves + 1])
          end
        end

        move(pos, -drow, -dcol)
      end
    end

    @cached_paths[cache_key] = res
  end

  def calculate_path_to_collect_all_keys_2(from = nil, keys = nil)
    from ||= @robots.first
    keys ||= @available_keys.keys

    return 0 if keys.empty?

    @cache2 ||= {}

    cache_key = [from, keys.sort.uniq.join("")]
    if @cache2.key?(cache_key)
        return @cache2[cache_key]
    end

    result = Float::INFINITY
    distance = calculate_path(from, keys)
    candidates = remaining_keys.map { |k| [k, distance[k]] }
    candidates.reject! { |c| c.last.nil? }

    candidates.each do |k, v|
       d = v + calculate_path_to_collect_all_keys_2(@available_keys[k], keys - [k])
       result = [result, d].min
    end

    @cache2[cache_key] = result
  end

  def calculate_path_to_collect_all_keys
    pq = PriorityQueue.new
    visited = Hash.new(Float::INFINITY)

    pq.push(state: [@robots.map { |row, col| [row, col] }, ""], total_moves: 0, priority: 0)
    visited[[@robots.map { |row, col| [row, col] }, ""]] = 0

    loop do
      node = pq.pop
      break if node.nil?

      robots, collected_keys = node[:state]
      total_moves = node[:total_moves]

      @collected_keys = collected_keys.split("")

      return total_moves if all_keys_collected?

      next if total_moves > visited[[robots, @collected_keys.sort.join("")]]

      distances = robots.map { |row, col| calculate_path([row, col], @available_keys.keys - @collected_keys) }
      candidates = []
      robots.length.times { |i| candidates += remaining_keys.map { |k| [i, k, distances[i][k]] } }
      candidates.reject! { |c| c.last.nil? }

      candidates.each do |candidate|
        index, key, moves = candidate
        pos = @available_keys[key]
        total_moves += moves

        @collected_keys.push(key)

        next_robots = robots.map { |row, col| [row, col] }
        next_robots[index] = [pos[0], pos[1]]

        if total_moves < visited[[next_robots, @collected_keys.sort.join("")]]
          visited[[next_robots, @collected_keys.sort.join("")]] = total_moves
          pq.push(state: [next_robots, @collected_keys.join("")], total_moves: total_moves, priority: -total_moves * @available_keys.length - @collected_keys.length)
        end

        @collected_keys.pop
        total_moves -= moves
      end
    end
  end
end

maze1 = Maze.new
puts maze1.calculate_path_to_collect_all_keys_2

# maze2 = Maze.new
# maze2.four_robots!
# puts maze2.calculate_path_to_collect_all_keys

puts $wasted
