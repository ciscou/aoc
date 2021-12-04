INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Board
  def initialize(cells)
    @cells = cells
    @seen = {}
  end

  attr_reader :last_number

  def see!(number)
    @last_number = number

    5.times do |row|
      5.times do |col|
        @seen[[row, col]] = true if @cells[row][col] == number
      end
    end
  end

  def solved?
    5.times.any? do |i|
      solved_row = 5.times.all? { |j| @seen[[i, j]] }
      solved_col = 5.times.all? { |j| @seen[[j, i]] }

      solved_row || solved_col
    end
  end

  def score
    5.times.sum do |row|
      5.times.sum do |col|
        @seen[[row, col]] ? 0 : @cells[row][col]
      end
    end
  end

  def inspect
    @cells.map(&:inspect)
  end
end

numbers = INPUT[0].split(",").map(&:to_i)

boards = INPUT[1..-1].each_slice(6).map do |slice|
  cells = slice[1..-1].map { |row| row.split(" ").map(&:to_i) }
  Board.new(cells)
end

winner = nil
loser = nil

numbers.each do |number|
  boards.each { |b| b.see!(number) }

  solved_boards = boards.select(&:solved?)

  solved_boards.each do |solved_board|
    winner ||= solved_board
    loser = solved_board
  end

  boards -= solved_boards

  break if boards.empty?
end

puts winner.score * winner.last_number
puts loser.score * loser.last_number
