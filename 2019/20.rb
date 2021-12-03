INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Maze
  def initialize
    @cells = INPUT.map(&:chars)
  end

  def parse_labels!
    @labels = Hash.new { |h, k| h[k] = [] }

    @cells.length.times do |row|
      (@cells[row].length - 2).times do |col|
        a = @cells[row][col]
        b = @cells[row][col + 1]
        c = @cells[row][col + 2]

        if ("A".."Z").include?(a) && ("A".."Z").include?(b) && c == "."
          @labels[a + b] << [row, col + 2]
        end

        if a == "." && ("A".."Z").include?(b) && ("A".."Z").include?(c)
          @labels[b + c] << [row, col]
        end
      end
    end

    @cells.first.length.times do |col|
      (@cells.length - 2).times do |row|
        a = @cells[row][col]
        b = @cells[row + 1][col]
        c = @cells[row + 2][col]

        if ("A".."Z").include?(a) && ("A".."Z").include?(b) && c == "."
          @labels[a + b] << [row + 2, col]
        end

        if a == "." && ("A".."Z").include?(b) && ("A".."Z").include?(c)
          @labels[b + c] << [row, col]
        end
      end
    end

    @row, @col = @labels["AA"].first

    @portals = {}

    @labels.each do |label, positions|
      next if label == "AA" || label == "ZZ"

      p1, p2 = positions
      @portals[p1] = p2
      @portals[p2] = p1
    end

    @level = 0
  end

  def move(drow, dcol)
    @last_row, @last_col, @last_level = @row, @col, @level

    @row += drow
    @col += dcol

    if ("A".."Z").include?(cell) && @portals.key?([@last_row, @last_col])
      if @last_row == 2 || @last_col == 2 || @last_row + 3 == @cells.length || @last_col + 3 == @cells.first.length
        if @level > 0
          @level -= 1
          @row, @col = @portals[[@last_row, @last_col]]
        end
      else
        @level += 1
        @row, @col = @portals[[@last_row, @last_col]]
      end
    end
  end

  def undo_last_move
    @row, @col, @level = @last_row, @last_col, @last_level
  end

  def valid_position?
    return false if @row < 0
    return false if @col < 0
    return false if @row >= @cells.length
    return false if @col >= @cells.first.length

    cell == "."
  end

  def cell
    @cells[@row][@col]
  end

  def solved?
    return false unless @level == 0

    [@row, @col] == @labels["ZZ"].first
  end

  def solve
    visited = {}
    queue = []

    visited[[@row, @col, @level]] = true
    queue.push([@row, @col, @level, 0])

    until queue.empty?
      node = queue.shift

      @row, @col, @level, moves = node

      if solved? # TODO
        puts "solved in #{moves} moves"
        break
      end

      available_moves = [[-1, 0], [1, 0], [0, -1], [0, 1]]
      available_moves.each do |drow, dcol|
        move(drow, dcol)
        if valid_position? && !visited[[@row, @col, @level]]
          visited[[@row, @col, @level]] = true
          queue.push([@row, @col, @level, moves + 1])
        end
        undo_last_move
      end
    end
  end
end

start = Time.now
maze = Maze.new
maze.parse_labels!
maze.solve
puts "solved in #{Time.now - start} seconds"
