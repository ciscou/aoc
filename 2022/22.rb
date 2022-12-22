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

  [row + drow, col + dcol]
end

[1, 2].each do |part|
  facing = :right
  row = 0
  col = 0
  col += 1 until GRID[row][col] == "."

  DIRECTIONS.each do |dir|
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
        next_facing = facing

        next_row, next_col = move(facing, next_row, next_col)
        if next_row < 0 || next_row >= HEIGHT || next_col < 0 || next_col >= WIDTH || GRID[next_row][next_col] == " "
          if part == 1
            next_row %= HEIGHT
            next_col %= WIDTH

            while GRID[next_row][next_col] == " "
              next_row, next_col = move(facing, next_row, next_col)
              next_row %= HEIGHT
              next_col %= WIDTH
            end
          else
            # input faces
            #  12
            #  3
            # 45
            # 6

            face = {
              [0, 1] => 1,
              [0, 2] => 2,
              [1, 1] => 3,
              [2, 0] => 4,
              [2, 1] => 5,
              [3, 0] => 6,
            }.fetch([row / 50, col / 50])

            case face
            when 1
              case facing
              when :right
                raise
              when :down
                raise
              when :left
                next_facing = :right
                next_row = 2 * 50 + 50 - row % 50 - 1
                next_col = 0 * 50
              when :up
                next_facing = :right
                next_row = 3 * 50 + col % 50
                next_col = 0 * 50
              end
            when 2
              case facing
              when :right
                next_facing = :left
                next_row = 2 * 50 + 50 - row % 50 - 1
                next_col = 2 * 50 - 1
              when :down
                next_facing = :left
                next_row = 1 * 50 + col % 50
                next_col = 2 * 50 - 1
              when :left
                raise
              when :up
                next_facing = :up
                next_row = 4 * 50 - 1
                next_col = 0 * 50 + col % 50
              end
            when 3
              case facing
              when :right
                next_facing = :up
                next_row = 1 * 50 - 1
                next_col = 2 * 50 + row % 50
              when :down
                raise
              when :left
                next_facing = :down
                next_row = 2 * 50
                next_col = 0 * 50 + row % 50
              when :up
                raise
              end
            when 4
              case facing
              when :right
                raise
              when :down
                raise
              when :left
                next_facing = :right
                next_row = 0 * 50 + 50 - row % 50 - 1
                next_col = 1 * 50
              when :up
                next_facing = :left
                next_row = 1 * 50 + col % 50
                next_col = 1 * 50
              end
            when 5
              case facing
              when :right
                next_facing = :left
                next_row = 0 * 50 + 50 - row % 50 - 1
                next_col = 3 * 50 - 1
              when :down
                next_facing = :left
                next_row = 3 * 50 + col % 50
                next_col = 1 * 50 - 1
              when :left
                raise
              when :up
                raise
              end
            when 6
              case facing
              when :right
                next_facing = :up
                next_row = 3 * 50 - 1
                next_col = 1 * 50 + row % 50
              when :down
                next_facing = :down
                next_row = 0 * 50
                next_col = 2 * 50 + col % 50
              when :left
                next_facing = :down
                next_row = 0 * 50
                next_col = 1 * 50 + row % 50
              when :up
                raise
              end
            else
              unreachable
            end

            next_face = {
              [0, 1] => 1,
              [0, 2] => 2,
              [1, 1] => 3,
              [2, 0] => 4,
              [2, 1] => 5,
              [3, 0] => 6,
            }.fetch([next_row / 50, next_col / 50])
          end
        end

        break if GRID[next_row][next_col] == "#"

        row = next_row
        col = next_col
        facing = next_facing
      end
    end
  end

  puts (row + 1) * 1000 + (col + 1) * 4 + %i[right down left up].index(facing)
end
