INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Tile
  def initialize(id:, cells:)
    @id = id
    @cells = cells
    @original_cells = cells
    @size = cells.length
  end

  def wetrun!
    @dryrun = false

    flips = @flips
    rotations = @rotations

    reset!
    flips.times { flip! }
    rotations.times { rotate! }
  end

  def dryrun!
    @cached_borders = {}

    2.times do |flips|
      4.times do |rotations|
        reset!
        flips.times { flip! }
        rotations.times { rotate! }

        @cached_borders[[flips, rotations, :top]] = top
        @cached_borders[[flips, rotations, :bottom]] = bottom
        @cached_borders[[flips, rotations, :left]] = left
        @cached_borders[[flips, rotations, :right]] = right
      end
    end

    @dryrun = true
  end

  def reset!
    @flips = 0
    @rotations = 0
    @cells = @original_cells
  end

  def flip!
    @flips += 1
    @flips %= 2

    return if @dryrun

    @cells = @cells.map(&:reverse)
  end

  def rotate!
    @rotations += 1
    @rotations %= 4

    return if @dryrun

    @cells = @cells.transpose.map(&:reverse)
  end

  attr_reader :id

  def tops
    @cached_borders.select { |k, v| k.last == :top }.map { |k, v| [k[0], k[1], v] }
  end

  def lefts
    @cached_borders.select { |k, v| k.last == :left }.map { |k, v| [k[0], k[1], v] }
  end

  def top
    return @cached_borders[[@flips, @rotations, :top]] if @dryrun

    @cells.first
  end

  def bottom
    return @cached_borders[[@flips, @rotations, :bottom]] if @dryrun

    @cells.last
  end

  def left
    return @cached_borders[[@flips, @rotations, :left]] if @dryrun

    @size.times.map { |i| @cells[i][0] }
  end

  def right
    return @cached_borders[[@flips, @rotations, :right]] if @dryrun

    @size.times.map { |i| @cells[i][@size-1] }
  end

  def can_go_right_to?(other_tile)
    other_tile.right == left
  end

  def can_go_below?(other_tile)
    other_tile.bottom == top
  end

  def cell_at(row, col)
    @cells[row][col]
  end

  def water_roughness
    roughness = 0

    @size.times do |row|
      @size.times do |col|
        if @cells[row][col] == "#"
          roughness += 1 unless @sea_monster_cells.key?([row, col])
        end
      end
    end

    roughness
  end

  def find_sea_monsters!
    sea_monster_pattern = [
      "                  # ".chars,
      "#    ##    ##    ###".chars,
      " #  #  #  #  #  #   ".chars
    ]

    @sea_monster_cells = {}

    sea_monsters_count = 0

    (@size - sea_monster_pattern.length).times do |row_offset|
      (@size - sea_monster_pattern.first.length).times do |col_offset|
        found = true

        sea_monster_pattern.length.times do |row|
          sea_monster_pattern.first.length.times do |col|
            next unless sea_monster_pattern[row][col] == "#"

            found = false unless @cells[row_offset + row][col_offset + col] == "#"
          end
        end

        if found
          sea_monsters_count += 1

          sea_monster_pattern.length.times do |row|
            sea_monster_pattern.first.length.times do |col|
              next unless sea_monster_pattern[row][col] == "#"

              @sea_monster_cells[[row_offset + row, col_offset + col]] = true
            end
          end
        end
      end
    end

    sea_monsters_count
  end
end

def valid_partial_solution?(solution)
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

tiles.each(&:dryrun!)

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

tiles_with_top = Hash.new { |h, k| h[k] = [] }
tiles_with_left = Hash.new { |h, k| h[k] = [] }

tiles.each_with_index do |tile, i|
  tile.tops.each { |top| tiles_with_top[top.last] << [i, top[0], top[1]] }
  tile.lefts.each { |left| tiles_with_left[left.last] << [i, left[0], left[1]] }
end

until queue.empty?
  tiles_specs = queue.shift

  available = tiles.length.times.to_a.group_by(&:itself)

  arrangement = tiles_specs.map do |idx, flip, rotate|
    available.delete(idx)

    tile = tiles[idx]
    tile.reset!
    flip.times { tile.flip! }
    rotate.times { tile.rotate! }
    tile
  end

  next unless valid_partial_solution?(arrangement)


  candidates = []

  if arrangement.size % SQUARE_SIZE == 0
    last_piece = arrangement[(arrangement.size - 1) / SQUARE_SIZE * SQUARE_SIZE]
    candidates += tiles_with_top[last_piece.bottom]
  else
    last_piece = arrangement.last
    candidates += tiles_with_left[last_piece.right]
  end

  candidates.uniq!
  candidates.select! { |candidate| available.key?(candidate.first) }

  candidates.each do |candidate|
    queue << tiles_specs + [candidate]
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

solution.each(&:wetrun!)

sea_monsters_image = []
(SQUARE_SIZE * 8).times { sea_monsters_image << [] }

SQUARE_SIZE.times do |tile_row|
  SQUARE_SIZE.times do |tile_col|
    8.times do |row|
      8.times do |col|
        sea_monsters_image[tile_row * 8 + row][tile_col * 8 + col] = solution[SQUARE_SIZE * tile_row + tile_col].cell_at(row + 1, col + 1)
      end
    end
  end
end

sea_monsters_tile = Tile.new(id: "sea_monsters", cells: sea_monsters_image)

2.times do |flips|
  4.times do |rotations|
    sea_monsters_tile.reset!
    flips.times { sea_monsters_tile.flip! }
    rotations.times { sea_monsters_tile.rotate! }

    if sea_monsters_tile.find_sea_monsters! > 0
      puts sea_monsters_tile.water_roughness
    end
  end
end
