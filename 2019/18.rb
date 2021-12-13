INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

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

# maze2 = Maze.new
# maze2.four_robots!
# puts maze2.calculate_path_to_collect_all_keys
