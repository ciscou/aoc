INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Maze
  def initialize
    @cells = INPUT.map(&:chars)

    @keys = []

    @cells.length.times do |row|
      @cells.first.length.times do |col|
        cell = @cells[row][col]
        @keys << cell if ("a".."z").include?(cell)
        @row, @col = [row, col] if cell == "@"
      end
    end

    @collected_keys = []
  end

  def move(drow, dcol)
    @row += drow
    @col += dcol
  end

  def valid_position?
    return false if @row < 0
    return false if @col < 0
    return false if @row >= @cells.length
    return false if @col >= @cells.first.length
    return false if cell == "#"
    return false if ("A".."Z").include?(cell) && !@collected_keys.include?(cell.downcase)

    true
  end

  def cell
    @cells[@row][@col]
  end

  def collect_key!
    if ("a".."z").include?(cell) && !@collected_keys.include?(cell)
      @collected_keys << cell
      cell
    end
  end

  def all_keys_collected?
    (@keys - @collected_keys).empty?
  end

  def solve
    visited = {}
    queue = []

    visited[[@row, @col, @collected_keys.sort.join("")]] = true
    queue.push([@row, @col, @collected_keys.join(""), 0])

    until queue.empty?
      node = queue.shift

      @row, @col, keys, moves = node
      @collected_keys = keys.split("")

      if all_keys_collected?
        puts "solved in #{moves} moves"
        puts "collected keys #{@collected_keys.inspect}"
        break
      end

      available_moves = [[-1, 0], [1, 0], [0, -1], [0, 1]]
      available_moves.each do |drow, dcol|
        move(drow, dcol)
        if valid_position? && !visited[[@row, @col, @collected_keys.sort.join("")]]
          @collected_keys_was = @collected_keys.join("").split("")
          collect_key!
          visited[[@row, @col, @collected_keys.sort.join("")]] = true
          queue.push([@row, @col, @collected_keys.join(""), moves + 1])
          @collected_keys = @collected_keys_was
        end
        move(-drow, -dcol)
      end
    end
  end
end

maze = Maze.new
maze.solve
