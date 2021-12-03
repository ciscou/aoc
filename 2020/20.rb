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

# solution = nil
# max_tiles_specs_size = 0

# until queue.empty?
#   tiles_specs = queue.pop

#   if tiles_specs.size > max_tiles_specs_size
#     max_tiles_specs_size = tiles_specs.size
#     puts max_tiles_specs_size
#   end

#   available = tiles.length.times.to_a

#   arrangement = tiles_specs.map do |idx, flip, rotate|
#     available.delete(idx)

#     tile = tiles[idx]
#     tile.reset!
#     flip.times { tile.flip! }
#     rotate.times { tile.rotate! }
#     tile
#   end

#   next unless valid_solution?(arrangement)

#   available.each do |idx|
#     2.times do |flip|
#       4.times do |rotate|
#         queue << tiles_specs + [[idx, flip, rotate]]
#       end
#     end
#   end

#   if arrangement.length == tiles.length
#     p tiles_specs
#     solution = arrangement
#     break
#   end
# end

# if solution.nil?
#   puts "no solution found!!!"
# else
#   puts [0, SQUARE_SIZE - 1, solution.length - SQUARE_SIZE, solution.length - 1].map { |idx| solution[idx].id }.inject(:*)
# end

# exit

tiles_specs = [[97, 1, 2], [126, 0, 1], [118, 1, 1], [10, 0, 3], [136, 0, 0], [134, 1, 1], [61, 0, 3], [93, 1, 3], [54, 1, 3], [49, 0, 0], [83, 1, 3], [90, 0, 2], [57, 1, 2], [5, 0, 3], [143, 0, 3], [45, 1, 3], [13, 0, 0], [65, 0, 2], [44, 1, 2], [78, 0, 3], [30, 1, 1], [1, 1, 2], [14, 1, 1], [124, 0, 0], [129, 0, 3], [4, 0, 0], [11, 1, 1], [64, 0, 1], [81, 0, 3], [7, 0, 2], [99, 0, 1], [75, 1, 1], [102, 0, 3], [123, 0, 3], [138, 0, 2], [82, 0, 1], [18, 1, 3], [77, 0, 0], [108, 0, 2], [91, 1, 1], [58, 1, 3], [32, 0, 3], [23, 1, 1], [135, 1, 2], [121, 0, 1], [116, 1, 2], [122, 0, 3], [42, 1, 1], [12, 0, 2], [125, 1, 3], [110, 1, 3], [127, 1, 1], [63, 0, 2], [137, 0, 0], [37, 0, 2], [105, 0, 3], [100, 0, 2], [120, 0, 2], [115, 1, 1], [114, 1, 3], [19, 1, 2], [43, 1, 2], [72, 1, 3], [84, 0, 0], [76, 0, 3], [70, 0, 0], [106, 1, 1], [56, 0, 2], [111, 1, 2], [139, 1, 2], [119, 1, 2], [52, 0, 2], [38, 0, 0], [130, 1, 1], [128, 1, 1], [107, 0, 1], [94, 0, 3], [109, 1, 2], [3, 0, 3], [51, 1, 1], [28, 0, 0], [92, 0, 1], [66, 0, 3], [133, 0, 1], [142, 0, 1], [113, 1, 3], [140, 0, 0], [141, 1, 2], [6, 0, 2], [50, 0, 3], [68, 0, 0], [132, 0, 0], [98, 1, 3], [27, 0, 1], [36, 0, 3], [74, 0, 2], [62, 0, 2], [2, 1, 2], [86, 1, 3], [96, 1, 1], [53, 1, 1], [104, 1, 1], [22, 0, 3], [29, 0, 2], [112, 0, 2], [73, 0, 1], [40, 1, 2], [20, 0, 1], [33, 1, 2], [8, 1, 3], [41, 0, 3], [59, 0, 2], [131, 1, 2], [21, 1, 3], [15, 0, 0], [35, 0, 0], [103, 0, 3], [79, 1, 1], [67, 0, 3], [85, 1, 2], [39, 1, 2], [25, 0, 1], [26, 0, 2], [89, 0, 2], [69, 1, 1], [60, 1, 2], [48, 1, 3], [80, 0, 3], [17, 0, 1], [71, 0, 1], [9, 0, 3], [101, 1, 1], [34, 1, 2], [95, 1, 2], [87, 0, 3], [24, 1, 3], [117, 0, 3], [0, 0, 3], [47, 1, 2], [55, 0, 2], [46, 0, 2], [31, 0, 1], [88, 1, 2], [16, 1, 1]]

solution = tiles_specs.map do |idx, flip, rotate|
  tile = tiles[idx]
  tile.reset!
  flip.times { tile.flip! }
  rotate.times { tile.rotate! }
  tile
end

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
