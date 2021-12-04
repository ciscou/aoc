INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Board
  def initialize(cells)
    @cells = cells
    @seen = {}
  end

  def see!(number)
    5.times do |row|
      5.times do |col|
        @seen[[row, col]] = true if @cells[row][col] == number
      end
    end
  end

  def solved?
    5.times do |i|
      return true if 5.times.all? { |j| @seen[[i, j]] }
      return true if 5.times.all? { |j| @seen[[j, i]] }
    end

    false
  end

  def score
    res = 0

    5.times do |row|
      5.times do |col|
        res += @cells[row][col] unless @seen[[row, col]]
      end
    end

    res
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

solved = []
last = nil

numbers.each do |number|
  last = number
  boards.each { |b| b.see!(number) }

  solved = boards.select(&:solved?)
  break if solved.any?
end

puts solved.first.score
puts last
puts solved.first.score * last
