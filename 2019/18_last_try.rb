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

class Cache
  def initialize
    @hits = 0
    @misses = 0
    @elems = {}
  end

  attr_reader :hits, :misses

  def get_or_put(key, &block)
    if @elems.key?(key)
      @hits += 1
      @elems[key]
    else
      @misses += 1
      @elems[key] = block.call
    end
  end
end

class Maze
  def initialize
    @cells = INPUT.map(&:chars)
    @height = @cells.length
    @width = @cells.map(&:length).max

    @robots = []
    @available_keys = {}

    @height.times do |row|
      @width.times do |col|
        pos = [row, col]

        @available_keys[cell_at(pos)] = pos if is_key?(pos)
        @robots << pos if is_robot?(pos)
      end
    end
  end

  def set_state!(state)
    @height.times do |row|
      @width.times do |col|
        @cells[row][col] = "." if @cells[row][col] == "@"
      end
    end

    @robots, @keys = state

    @keys.keys.each do |key|
      row, col = key_position(key)

      @cells[row][col] = "."

      @height.times do |row|
        @width.times do |col|
          @cells[row][col] = "." if @cells[row][col] == door_for(key)
        end
      end
    end

    @robots.each do |row, col|
      @cells[row][col] = "@"
    end
  end

  def draw
    @height.times do |row|
      line = @width.times.map { |col| cell_at(row, col) }
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

  def cell_at(pos_or_row, col = nil)
    row, col = col.nil? ? pos_or_row : [pos_or_row, col]

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

  def solve
    @key_distances_cache = Cache.new

    queue = PriorityQueue.new

    # TODO more robots?
    queue.push(
      state: [robot_position(0), 0, {}], # current position, distance travelled, collected keys
      priority: 0
    )

    visited = {}

    loop do
      node = queue.pop
      break if node.nil?

      state = node[:state]
      pos, dist, collected_keys = state

      return dist if (available_keys - collected_keys.keys).empty?

      next if visited[[pos, collected_keys]]
      visited[[pos, collected_keys]] = true

      # TODO more robots?
      calculate_distances(pos).each do |candidate_key|
        key_pos, key_dist, crossed_doors = candidate_key
        key = cell_at(key_pos)

        next if collected_keys[key]
        next unless crossed_doors.keys.all? { |door| collected_keys[key_for(door)] }

        queue.push(
          state: [key_pos, dist + key_dist, collected_keys.merge(key => true)],
          priority: -(dist + key_dist)
        )
      end
    end

    Float::INFINITY
  end

  private

  def calculate_distances(from)
    @key_distances_cache.get_or_put([from]) { do_calculate_distances(from) }
  end

  def do_calculate_distances(from)
    res = []

    queue = []
    queue.push([from, 0, {}]) # current position, distance travelled, crossed doors

    visited = {}

    until queue.empty?
      pos, dist, doors = queue.pop

      next if visited[pos]
      visited[pos] = true

      res << [pos, dist, doors] if is_key?(pos)

      neighbours(pos).each do |neighbour|
        next if is_wall?(neighbour)

        next_doors = doors.merge(is_door?(neighbour) ? { cell_at(neighbour) => true } : {})

        queue << [neighbour, dist + 1, next_doors]
      end
    end

    res
  end

  def key_for(door)
    door.downcase
  end

  def door_for(key)
    key.upcase
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
  maze = Maze.new

  maze.four_robots! if four_robots

  start = Time.now
  solution = maze.solve
  puts "done in #{Time.now - start} seconds"

  unless solution
    return "no solution found!"
  end

  "Found solution in #{solution} moves"
end

def part1
  solve(false)
end

def part2
  solve(true)
end

puts part1
puts part2
