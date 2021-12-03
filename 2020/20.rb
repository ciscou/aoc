INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Tile
  def initialize(id:, cells:)
    @id = id
    @cells = cells
    @flips = 0
    @rotations = 0
  end

  def reset!
    @flips = 0
    @rotations = 0
  end

  def flip!
    @flips += 1
    @flips %= 2
  end

  def rotate!
    @rotations += 1
    @rotations %= 4
  end

  def encode_borders
    @borders = {}

    2.times do |flip|
      4.times do |rotate|
        cells = @cells.map { |row| row.map { |cell| cell } }

        flip.times do
          cells.first.reverse!
          cells.last.reverse!

          (1..8).each do |i|
            cells[i][0], cells[i][9] = cells[i][9], cells[i][0]
          end
        end

        rotate.times do
          tmp = cells[0].map { |cell| cell }

          10.times { |i| cells[0][i] = cells[9-i][0] }
          10.times { |i| cells[i][0] = cells[9][i] }
          10.times { |i| cells[9][i] = cells[9-i][9] }
          10.times { |i| cells[i][9] = tmp[i] }
        end

        @borders[flip] ||= {}
        @borders[flip][rotate] ||= {}
        @borders[flip][rotate][:top] = encode_border(cells.first)
        @borders[flip][rotate][:bottom] = encode_border(cells.last)
        @borders[flip][rotate][:left] = encode_border(10.times.map { |i| cells[i][0] })
        @borders[flip][rotate][:right] = encode_border(10.times.map { |i| cells[i][9] })
      end
    end
  end

  attr_reader :id

  def top
    @borders[@flips][@rotations][:top]
  end

  def bottom
    @borders[@flips][@rotations][:bottom]
  end

  def left
    @borders[@flips][@rotations][:left]
  end

  def right
    @borders[@flips][@rotations][:right]
  end

  def can_go_right_to?(other_tile)
    other_tile.right == left
  end

  def can_go_below?(other_tile)
    other_tile.bottom == top
  end

  private

  def encode_border(border)
    border.map { |c| c == "#" ? 1 : 0 }.join.to_i(2)
  end
end

def valid_arrangement?(arrangement)
  square = []
  SQUARE_SIZE.times do |i|
    square << []
    SQUARE_SIZE.times do |j|
      square.last << arrangement[i * SQUARE_SIZE + j]
    end
  end

  SQUARE_SIZE.times do |row|
    SQUARE_SIZE.times do |col|
      tile = square[row][col]

      next if tile.nil?

      return false if row > 0 && !tile.can_go_below?(square[row-1][col])
      return false if col > 0 && !tile.can_go_right_to?(square[row][col-1])
    end
  end

  true
end

tiles = INPUT.each_slice(12).map do |lines|
  Tile.new(id: lines[0].split(" ").last.to_i, cells: lines[1, 10].map(&:chars))
end

tiles.each(&:encode_borders)

SQUARE_SIZE = Math.sqrt(tiles.size).round

queue = []
# visited = {}

tiles.length.times do |idx|
  2.times do |flip|
    4.times do |rotate|
      queue << [[idx, flip, rotate]]
      # visited[[idx, flip, rotate]] = true
    end
  end
end

solution = nil
max_tiles_specs_size = 0

until queue.empty?
  tiles_specs = queue.pop

  if tiles_specs.size > max_tiles_specs_size
    max_tiles_specs_size = tiles_specs.size
    # p tiles_specs
    puts max_tiles_specs_size
  end

  available = tiles.length.times.to_a

  arrangement = tiles_specs.map do |idx, flip, rotate|
    available.delete(idx)

    tile = tiles[idx]
    tile.reset!
    flip.times { tile.flip! }
    rotate.times { tile.rotate! }
    tile
  end

  next unless valid_arrangement?(arrangement)

  available.each do |idx|
    2.times do |flip|
      4.times do |rotate|
        queue << tiles_specs + [[idx, flip, rotate]]
      end
    end
  end

  if arrangement.length == tiles.length
    solution = arrangement
    break
  end
end

if solution.nil?
  puts "no solution found!!!"
else
  puts [0, SQUARE_SIZE - 1, solution.length - SQUARE_SIZE, solution.length - 1].map { |idx| solution[idx].id }.inject(:*)
end
