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

  def set_state!(state)
    @cells.length.times do |row|
      @cells[row].length.times do |col|
        @cells[row][col] = "." if @cells[row][col] == "@"
      end
    end

    @robots, @keys = state

    @keys.keys.each do |key|
      row, col = key_position(key)

      @cells[row][col] = "."

      @cells.length.times do |row|
        @cells[row].length.times do |col|
          @cells[row][col] = "." if @cells[row][col] == key.upcase
        end
      end
    end

    @robots.each do |row, col|
      @cells[row][col] = "@"
    end
  end

  def draw
    @cells.length.times do |row|
      line = @cells[row].length.times.map { |col| cell_at([row, col]) }
      puts line.join("")
    end
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
      @cells[robot[0]][robot[1]] = "@"
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

  def print_all_paths
    @calculated_paths.each do |from, v1|
      v1.each do |to, path|
        print "Path from #{cell_at(from)} to #{cell_at(to)}: "
        puts cells_at(path.select { |pos| is_robot?(pos) || is_key?(pos) || is_door?(pos) }).join("")
      end
    end
  end

  def calculated_paths(from, keys)
    @calculated_paths ||= {}

    unless @calculated_paths.key?(from)
      @calculated_paths[from] = {}
      calculate_all_paths!(from, keys)
    end

    @calculated_paths[from].values
  end

  def find_min_path_to_all_keys
    # Dijkstra

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

      $nodes_count += 1

      robots_count.times do |index|
        pos = robots[index]

        calculated_paths(pos, keys).each do |path|
          next if keys[cell_at(path.last)]

          next_keys = keys.dup

          path.each do |pos|
            next_keys[cell_at(pos)] = true if is_key?(pos)
          end

          next if closed_doors(path, next_keys).any?

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

    nil
  end

  private

  def closed_doors(path, keys = {})
    doors = []

    path.each do |pos|
      keys[cell_at(pos)] = true if is_key?(pos)
      doors << pos if is_door?(pos) && !keys[key_for(cell_at(pos))]
    end

    doors
  end

  def calculate_all_paths!(start, keys)
    do_calculate_all_paths!(start, start, [start], keys, start => true)
  end

  def do_calculate_all_paths!(start, from, path, keys, visited)
    # DFS w/o early returns so that we exhaust all possibilities
    # Well, actually we early return to discard redundant paths

    if path.length > 1 && is_key?(from)
      # TODO this optimization fails if a key position needs to be visited again
      # as an intermediate step to get another key. It works for part1 and part2
      # but breaks for some examples
      return if keys[cell_at(from)]

      doors = closed_doors(path)
      add_this_path = false

      other_path = @calculated_paths[start][from]
      if other_path
        other_doors = closed_doors(other_path)

        add_this_path = true if path.length < other_path.length
        add_this_path = true if (doors - other_doors).empty? && (other_doors - doors).any?
      else
        add_this_path = true
      end

      if add_this_path
        @calculated_paths[start][from] = path.dup
      else
        "ignoring path"
      end
    end

    $coordinates_count += 1

    visited[from] = true

    neighbours(from).each do |neighbour|
      next if visited[neighbour]
      next if is_wall?(neighbour)

      path.push(neighbour)

      do_calculate_all_paths!(start, neighbour, path, keys, visited)

      path.pop
    end

    visited[from] = false
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

  def is_empty?(pos)
    cell_at(pos) == "."
  end
end

def solve(four_robots)
  $coordinates_count = 0
  $nodes_count = 0

  maze = Maze.new

  maze.four_robots! if four_robots

  print "calculating solution... "
  start = Time.now
  solution = maze.find_min_path_to_all_keys
  puts "done in #{Time.now - start} seconds"

  # maze.print_all_paths

  unless solution
    puts "no solution found!"
    return
  end

  node, distances, parents = solution

  history = []
  state = node[:state]

  while state
    history.push(state)
    state = parents[state]
  end

  moves, history = solution

  # reconstruct(history, false)

  puts "Processed #{$coordinates_count} coordinates and #{$nodes_count} nodes"
  puts "Found solution in #{moves} moves"

  [node[:priority] * -1, history.reverse]
end

def reconstruct(history, four_robots)
  maze = Maze.new

  maze.four_robots! if four_robots

  last_state = nil
  history.each do |state|
    if last_state
      last_robots = last_state.first
      robots = state.first
      moved_robot = (robots - last_robots).first

      puts "Grab #{maze.cell_at(moved_robot)}"
      $stdin.gets
    end

    last_state = state

    maze.set_state!(state)
    maze.draw
    puts
  end
end

def part1
  solve(false)
end

def part2
  solve(true)
end

puts "part 1"
part1

puts

puts "part 2"
part2
