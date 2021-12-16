INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

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
    @best_score_cache = Cache.new

    res = find_min_path_to_all_keys(robots_count.times.map { |i| robot_position(i) }, {})

    puts "key distances cache #{@key_distances_cache.hits}/#{@key_distances_cache.misses}"
    puts "best score cache #{@best_score_cache.hits}/#{@best_score_cache.misses}"

    res
  end

  private

  def calculate_distance(from, to, collected_keys)
    @key_distances_cache.get_or_put([from, to, collected_keys.keys.sort]) { do_calculate_distance(from, to, collected_keys) }
  end

  def do_calculate_distance(from, to, collected_keys)
    queue = []
    queue << [from, 0]

    visited = {}
    visited[from] = true

    until queue.empty?
      pos, dist = queue.pop

      return dist if pos == to

      visited[pos] = true

      neighbours(pos).each do |next_pos|
        next if visited[next_pos]
        next if is_wall?(next_pos)
        next if is_key?(next_pos) && !collected_keys[cell_at(next_pos)] && next_pos != to
        next if is_door?(next_pos) && !collected_keys[key_for(cell_at(next_pos))]

        queue << [next_pos, dist + 1]
      end
    end

    Float::INFINITY
  end

  def find_min_path_to_all_keys(positions, collected_keys)
    @best_score_cache.get_or_put([positions, collected_keys.keys.sort]) { do_find_min_path_to_all_keys(positions, collected_keys) }
  end

  def do_find_min_path_to_all_keys(positions, collected_keys)
    remaining_keys = (available_keys - collected_keys.keys)
    return 0 if remaining_keys.empty?

    best = Float::INFINITY

    positions.each.with_index do |pos, i|
      remaining_keys.each do |key|
        dist = calculate_distance(pos, key_position(key), collected_keys)

        next if dist.infinite?

        next_positions = positions.dup
        next_positions[i] = key_position(key)
        next_dist = dist
        next_collected_keys = collected_keys.merge(key => true)
        candidate = next_dist + find_min_path_to_all_keys(next_positions, next_collected_keys)

        if candidate < best
          best = candidate
        end
      end
    end

    best
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
