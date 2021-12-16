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
    @entries = {}
  end

  attr_reader :hits, :misses

  def get_or_put(key, &block)
    if @entries.key?(key)
      @hits += 1
      @entries[key]
    else
      @misses += 1
      @entries[key] = block.call
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
      row >= @height ||
      col >= @width
    end
  end

  def solve
    @key_distances_cache = Cache.new

    # current positions, distance travelled, encoded collected keys
    initial_state = [robots_count.times.map { |i| robot_position(i) }, 0, 0]

    pq = PriorityQueue.new
    pq.push(
      state: initial_state,
      priority: 0
    )

    visited = {}

    enc_available_keys = available_keys.sum { |k| encode_key(k) }

    loop do
      node = pq.pop
      break if node.nil?

      state = node[:state]
      positions, dist, enc_collected_keys = state

      return dist if enc_available_keys == enc_collected_keys

      next if visited[[positions, enc_collected_keys]]
      visited[[positions, enc_collected_keys]] = true

      positions.each.with_index do |pos, i|
        calculate_distances(pos).each do |candidate_key|
          collected_key_pos, collected_key_dist, enc_collected_key, enc_crossed_doors = candidate_key

          next unless enc_collected_keys & enc_collected_key == 0  # next unless we haven't collected that key yet
          next unless enc_crossed_doors & ~enc_collected_keys == 0 # next unless we have the key for that door

          next_positions = positions.dup
          next_positions[i] = collected_key_pos

          pq.push(
            state: [next_positions, dist + collected_key_dist, enc_collected_keys | enc_collected_key],
            priority: -(dist + collected_key_dist)
          )
        end
      end
    end

    Float::INFINITY
  end

  private

  def encode_key(key)
    1 << (key.ord - 'a'.ord)
  end

  def encode_door(door)
    1 << (key_for(door).ord - 'a'.ord)
  end

  def calculate_distances(from)
    @key_distances_cache.get_or_put([from]) { do_calculate_distances(from) }
  end

  def do_calculate_distances(from)
    res = []

    # current position, distance travelled, encoded crossed doors
    initial_state = [from, 0, 0]

    queue = []
    queue.push(initial_state)

    visited = {}
    visited[from] = true

    until queue.empty?
      pos, dist, enc_doors = queue.shift

      if is_key?(pos)
        encoded_key = encode_key(cell_at(pos))

        res << [pos, dist, encoded_key, enc_doors]
      end

      neighbours(pos).each do |neighbour|
        next if visited[neighbour]
        visited[neighbour] = true

        next if is_wall?(neighbour)

        enc_next_doors = enc_doors | (is_door?(neighbour) ? encode_door(cell_at(neighbour)) : 0)

        queue << [neighbour, dist + 1, enc_next_doors]
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
