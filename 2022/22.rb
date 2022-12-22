INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

TURN_R = {
  right: :down,
   down: :left,
   left: :up,
     up: :right,
}

TURN_L = TURN_R.invert

MOVE = {
  right: [ 0,  1],
   down: [ 1,  0],
   left: [ 0, -1],
     up: [-1,  0],
}

GRID = INPUT[0..-3].map(&:chars)

HEIGHT = GRID.length
WIDTH  = GRID.map(&:length).max

GRID.each do |line|
  line << " " while line.length < WIDTH
end

DIRECTIONS = INPUT.last.scan(/\d+|R|L/).map do |match|
  {
    "R" => { turn: :right },
    "L" => { turn: :left },
  }.fetch(match) { {move: match.to_i } }
end

def turn(facing, dir)
  h = dir == :left ? TURN_L : TURN_R
  h.fetch(facing)
end

def move(facing, row, col)
  drow, dcol = MOVE.fetch(facing)

  row += drow
  col += dcol

  row %= HEIGHT
  col %= WIDTH

  [row, col]
end

facing = :right
row = 0
col = 0
col += 1 until GRID[row][col] == "."

DIRECTIONS.each do |dir|
  # p [row, col, dir]
  # ([row-15, 0].max..[row+15, HEIGHT-1].min).each do |r|
  #   line = GRID[r].dup
  #   if r == row
  #     line[col] = { right: ">", down: "v", left: "<", up: "^" }.fetch(facing)
  #   end
  #   puts line.join
  # end
  # gets

  if dir[:turn]
    facing = turn(facing, dir[:turn])
  else
    dir[:move].times do
      next_row = row
      next_col = col

      begin
        next_row, next_col = move(facing, next_row, next_col)
      end while GRID[next_row][next_col] == " "

      break if GRID[next_row][next_col] == "#"

      row = next_row
      col = next_col

      # p [row, col, dir]
      # ([row-15, 0].max..[row+15, HEIGHT-1].min).each do |r|
      #   line = GRID[r].dup
      #   if r == row
      #     line[col] = { right: ">", down: "v", left: "<", up: "^" }.fetch(facing)
      #   end
      #   puts line.join
      # end
      # gets
    end
  end
end

part1 = (row + 1) * 1000 + (col + 1) * 4 + %i[right down left up].index(facing)
puts part1
