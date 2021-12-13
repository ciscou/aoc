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

  attr_reader :available_keys # TODO: unexpose

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

  # def calculate_all_paths_from_this_key_to_all_other_keys(start, the_end, path, visited)
  #   @omgcache ||= {}

  #   cached = @omgcache[[start, the_end, visited]]

  #   if cached
  #     puts "hit!"
  #     return cached
  #   end

  #   res = calculate_all_paths_from_this_key_to_all_other_keys_helper(start, the_end, path, visited)
  #   @omgcache[[start, the_end, visited]] = res
  #   @omgcache[[the_end, start, visited]] = res.reverse

  #   res
  # end

  def calculate_all_paths_from_this_key_to_all_other_keys(start, the_end, path, visited)
    # TODO
    # TODO
    # TODO
    # TODO actually only return if we have collected all keys
    # TODO actually do not return ever, as we need to exhaust all possibilities
    # TODO maybe (maybe) try to be smart and remove paths that don't make sense
    # TODO like if you have aBb bCc, you do not need aBbCc
    # TODO maybe instead of returning add it to a list
    # TODO
    # TODO
    # TODO

    if start == the_end
      return [path.dup]
    end

    res = []

    neighbours(start).each do |adjacent|
      cell = cell(adjacent)
      # TODO: add 1 2 3 4 to . @ (four robots)
      if !visited[adjacent] && ([".", "@"].include?(cell) || ("a".."z").include?(cell) || ("A".."Z").include?(cell))
        visited[adjacent] = true
        path.push(adjacent)

        # wtf using cache is slower???
        res += calculate_all_paths_from_this_key_to_all_other_keys(adjacent, the_end, path, visited)

        path.pop
        visited.delete(adjacent)
      end
    end

    res
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
    time_start = Time.now
    precalculated = {}
    @available_keys.values.each do |start|
      puts cell(start)
      precalculated[start] = []
      @available_keys.values.each do |the_end|
        next if start == the_end
        precalculated[start] += calculate_all_paths_from_this_key_to_all_other_keys(start, the_end, [start], { start => true })
      end
    end
    @robots.each do |start|
      puts cell(start)
      precalculated[start] = []
      @available_keys.values.each do |the_end|
        precalculated[start] += calculate_all_paths_from_this_key_to_all_other_keys(start, the_end, [start], { start => true })
      end
    end

    # precalculated.each do |k, v|
    #   puts [cell(k), v.map(&:length)].inspect
    # end

    puts "done precalculating in #{Time.now - time_start}s"

    time_start = Time.now

#   precalculated.each do |pos, paths|
#     puts cell(pos)
#     paths.each do |path|
#       puts "  #{path.map { |pos| cell(pos) }.join(" ")}"
#       gets
#     end
#   end

    pq = PriorityQueue.new
    visited = Hash.new(Float::INFINITY)

    pq.push(state: [@robots.map { |row, col| [row, col] }, ""], total_moves: 0, priority: 0)
    visited[[@robots.map { |row, col| [row, col] }, ""]] = 0

    loop do
      node = pq.pop
      break if node.nil?

      robots, collected_keys = node[:state]
      total_moves = node[:total_moves]

      collected_keys = collected_keys.split("")

      if collected_keys.size == @available_keys.size
        # puts "done!!!"
        # puts node.inspect
        # gets
        puts "all done in #{Time.now - time_start}s"
        return total_moves
      end

      next if total_moves > visited[[robots, collected_keys.sort.join("")]]

      candidates = []
      robots.each.with_index do |pos, index|
        # puts node.inspect
        # puts precalculated.inspect
        # gets

        precalculated[pos].each { |path| candidates << [index, path] }
      end

      # candidates.map(&:last).each do |path|
      #   puts path.map { |pos| cell(pos) }.join("")
      #   gets
      # end

      candidates.each do |candidate|
        index, paths = candidate

        key = cell(paths.last)
        moves = paths.length - 1 # TODO -1???
        pos = @available_keys[key] || @robots.first # TODO or 1234 (four robots)

        # puts paths.map { |pos| cell(pos) }.join("")
        # puts "total moves is #{total_moves}"
        # puts "moves is #{moves}"
        # gets

        path_doors = paths.map { |pos| cell(pos) }.select { |cell| ("A".."Z").include?(cell) }

        # if collected_keys.any?
        #   puts paths.map { |pos| cell(pos) }.join("")
        #   puts [path_doors, collected_keys].inspect
        #   gets
        # end

        # TODO avoid going to the same key twice????? or is it already visited???
        next if collected_keys.include?(cell(paths.last))
        next if (path_doors - collected_keys.map(&:upcase)).any?

        collected_keys_was = collected_keys.dup
        paths.map { |pos| cell(pos) }.select { |cell| ("a".."z").include?(cell) }.each { |key| collected_keys.push(key) unless collected_keys.include?(key) }

        next_robots = robots.map { |row, col| [row, col] }

        # puts paths.map { |pos| cell(pos) }.join("")
        # puts key.inspect
        # puts collected_keys.inspect
        # puts path_doors.inspect
        # puts next_robots.inspect
        # puts pos
        # gets

        next_robots[index] = [pos[0], pos[1]]

        # aqui aqui aqui
#       puts "I'm at #{cell(robots[index]).inspect} after #{total_moves} moves, I have collected #{collected_keys_was.inspect} keys and I can go to #{cell(next_robots[index]).inspect} in #{moves} moves"
#       gets

        total_moves += moves

        if total_moves < visited[[next_robots, collected_keys.sort.join("")]]
          # what if we do not use a PQ but a normal Q?

          # puts paths.map { |pos| cell(pos) }.join("")
          # puts key.inspect
          # puts collected_keys.inspect
          # puts path_doors.inspect
          # gets

          visited[[next_robots, collected_keys.sort.join("")]] = total_moves
          pq.push(state: [next_robots, collected_keys.join("")], total_moves: total_moves, priority: -total_moves) # TODO heuristic collected keys???
        end

        collected_keys = collected_keys_was
        total_moves -= moves
      end
    end
  end
end

maze1 = Maze.new
puts maze1.calculate_path_to_collect_all_keys

# maze2 = Maze.new
# maze2.four_robots!
# puts maze2.calculate_path_to_collect_all_keys
