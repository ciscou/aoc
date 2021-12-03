INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

$max_moves = 0
$max_collected_keys = 0

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

  def setup_part_1!
    @row = [@row]
    @col = [@col]
  end

  def setup_part_2!
    @cells[@row][@col] = "#"

    @cells[@row+1][@col] = "#"
    @cells[@row-1][@col] = "#"
    @cells[@row][@col+1] = "#"
    @cells[@row][@col-1] = "#"

    @cells[@row+1][@col+1] = "@"
    @cells[@row+1][@col-1] = "@"
    @cells[@row-1][@col+1] = "@"
    @cells[@row-1][@col-1] = "@"

    @row = []
    @col = []

    @cells.length.times do |row|
      @cells.first.length.times do |col|
        cell = @cells[row][col]
        @keys << cell if ("a".."z").include?(cell)
        if cell == "@"
          @row << row
          @col << col
        end
      end
    end
  end

  def move(index, drow, dcol)
    @row[index] += drow
    @col[index] += dcol
  end

  def valid_position?
    @row.length.times do |index|
      return false if @row[index] < 0
      return false if @col[index] < 0
      return false if @row[index] >= @cells.length
      return false if @col[index] >= @cells.first.length
      return false if cell(index) == "#"
      return false if ("A".."Z").include?(cell(index)) && !@collected_keys.include?(cell(index).downcase)
    end

    true
  end

  def cell(index)
    @cells[@row[index]][@col[index]]
  end

  def collect_key!(index)
    if ("a".."z").include?(cell(index)) && !@collected_keys.include?(cell(index))
      @collected_keys << cell(index)
      cell(index)
    end
  end

  def all_keys_collected?
    (@keys - @collected_keys).empty?
  end

  def solve
    visited = {}
    queue = []

    visited[[@row.dup, @col.dup, @collected_keys.sort.join("")]] = true
    queue.push([@row.dup, @col.dup, @collected_keys.join(""), 0])

    until queue.empty?
      node = queue.shift

      @row, @col, keys, moves = node
      @collected_keys = keys.split("")

      if moves > $max_moves
        $max_moves = moves
        puts "max moves: #{moves}"
      end

      if keys.size > $max_collected_keys
        $max_collected_keys = keys.length
        puts "max collected keys: #{keys.length}"
      end

      if keys.length == 0
        if moves > 50
          next
        end
      elsif moves / keys.length > 50
        next
      end

      # if moves > 50
      #   puts "next"
      #   next
      # end

      if all_keys_collected?
        puts "solved in #{moves} moves"
        puts "collected keys #{@collected_keys.inspect}"
        break
      end

      available_moves = [[-1, 0], [1, 0], [0, -1], [0, 1]]
      @row.length.times do |index|
        available_moves.each do |drow, dcol|
          move(index, drow, dcol)
          if valid_position? && !visited[[@row.dup, @col.dup, @collected_keys.sort.join("")]]
            @collected_keys_was = @collected_keys.join("").split("")
            collect_key!(index)
            visited[[@row.dup, @col.dup, @collected_keys.sort.join("")]] = true
            queue.push([@row.dup, @col.dup, @collected_keys.join(""), moves + 1])
            @collected_keys = @collected_keys_was
          end
          move(index, -drow, -dcol)
        end
      end
    end
  end
end

# start = Time.now
# maze1 = Maze.new
# maze1.setup_part_1!
# maze1.solve
# puts "solved in #{Time.now - start} seconds"

start = Time.now
maze2 = Maze.new
maze2.setup_part_2!
maze2.solve
puts "solved in #{Time.now - start} seconds"
