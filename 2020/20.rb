INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Tile
  def initialize(id:, cells:)
    @id = id
    @cells = cells
    @original_cells = cells
    @flips = 0
    @rotations = 0
    @size = cells.length
  end

  def reset!
    @flips = 0
    @rotations = 0
    @cells = @original_cells
  end

  def flip!
    @flips += 1
    @flips %= 2
    @cells = @cells.map(&:reverse)
  end

  def rotate!
    @rotations += 1
    @rotations %= 4
    @cells = @cells.transpose.map(&:reverse)
  end

  def encode_borders
    @borders = {}

    2.times do |flips|
      4.times do |rotations|
        reset!
        flips.times { flip! }
        rotations.times { rotate! }

        @borders[flips] ||= {}
        @borders[flips][rotations] ||= {}
        @borders[flips][rotations][:top] = encode_border(@cells.first)
        @borders[flips][rotations][:bottom] = encode_border(@cells.last)
        @borders[flips][rotations][:left] = encode_border(@size.times.map { |i| @cells[i][0] })
        @borders[flips][rotations][:right] = encode_border(@size.times.map { |i| @cells[i][@size-1] })
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

  def cell_at
    
  end

  private

  def encode_border(border)
    border.map { |c| c == "#" ? 1 : 0 }.join.to_i(2)
  end
end

def valid_solution?(solution)
  solution.each_with_index do |tile, index|
    next if tile.nil?

    row, col = index.divmod(SQUARE_SIZE)

    return false if row > 0 && !tile.can_go_below?(solution[(row - 1) * SQUARE_SIZE + col])
    return false if col > 0 && !tile.can_go_right_to?(solution[row * SQUARE_SIZE + (col - 1)])
  end

  true
end

tiles = INPUT.each_slice(12).map do |lines|
  Tile.new(id: lines[0].split(" ").last.to_i, cells: lines[1, 10].map(&:chars))
end

tiles.each(&:encode_borders)

SQUARE_SIZE = Math.sqrt(tiles.size).round

queue = []

tiles.length.times do |idx|
  2.times do |flip|
    4.times do |rotate|
      queue << [[idx, flip, rotate]]
    end
  end
end

solution = nil
max_tiles_specs_size = 0

until queue.empty?
  tiles_specs = queue.pop

  if tiles_specs.size > max_tiles_specs_size
    max_tiles_specs_size = tiles_specs.size
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

  next unless valid_solution?(arrangement)

  available.each do |idx|
    2.times do |flip|
      4.times do |rotate|
        queue << tiles_specs + [[idx, flip, rotate]]
      end
    end
  end

  if arrangement.length == tiles.length
    p tiles_specs
    solution = arrangement
    break
  end
end

if solution.nil?
  puts "no solution found!!!"
else
  puts [0, SQUARE_SIZE - 1, solution.length - SQUARE_SIZE, solution.length - 1].map { |idx| solution[idx].id }.inject(:*)
end
