require 'ruby2d'

# Define constants
INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

CELL_SIZE = 35

GRID_INPUT, MOVES_INPUT = INPUT.chunk { _1.empty? && nil }.map(&:last)

GRID = GRID_INPUT.map do |line|
  line.chars.flat_map do |char|
    case char
    when "#" then "##"
    when "O" then "[]"
    when "." then ".."
    when "@" then "@."
    else raise "wtf #{char.inspect}"
    end.chars
  end
end

HEIGHT = GRID.length
WIDTH = GRID.first.length

MOVES = MOVES_INPUT.flat_map do |line|
  line.chars.map do |move|
    {
      "^" => [-1, 0],
      "v" => [1, 0],
      "<" => [0, -1],
      ">" => [0, 1],
    }.fetch(move)
  end
end

robot = nil
HEIGHT.times do |r|
  WIDTH.times do |c|
    if GRID[r][c] == "@"
      robot = [r, c]
    end
  end
end

WALL_IMG = Image.new("wall.png", width: CELL_SIZE, height: CELL_SIZE, show: false)
BOX_IMG = Image.new("box.png", width: CELL_SIZE, height: CELL_SIZE, show: false)
BOX_LEFT_IMG = Image.new("box-left.png", width: CELL_SIZE, height: CELL_SIZE, show: false)
BOX_RIGHT_IMG = Image.new("box-right.png", width: CELL_SIZE, height: CELL_SIZE, show: false)
ROBOT_IMG = Image.new("robot.png", width: CELL_SIZE, height: CELL_SIZE, show: false)

moves_idx = 0

def can_move?(pos, move, other: false)
  r, c = pos
  dr, dc = move
  nr = r + dr
  nc = c + dc

  case GRID[nr][nc]
  when "."
    true
  when "#"
    false
  when "O"
    can_move?([nr, nc], move)
  when "["
    if dr == 0 || other
      can_move?([nr, nc], move)
    else
      can_move?([nr, nc], move) && can_move?([r, c+1], move, other: true)
    end
  when "]"
    if dr == 0 || other
      can_move?([nr, nc], move)
    else
      can_move?([nr, nc], move) && can_move?([r, c-1], move, other: true)
    end
  else
    raise "wtf #{GRID[nr][nc].inspect}"
  end
end

def move!(pos, move, other: false)
  r, c = pos
  dr, dc = move
  nr = r + dr
  nc = c + dc

  move!([nr, nc], move) unless GRID[nr][nc] == "."
  move!([r, c+1], move, other: true) if !other && GRID[r][c] == "[" && dr != 0
  move!([r, c-1], move, other: true) if !other && GRID[r][c] == "]" && dr != 0
  GRID[r][c], GRID[nr][nc] = GRID[nr][nc], GRID[r][c] 
end

set title: "Advent of Code 2024 15", width: CELL_SIZE * 42, height: CELL_SIZE * 21

offset_x = 28
offset_y = 14

def draw_grid(offset_x, offset_y)
  HEIGHT.times do |y|
    WIDTH.times do |x|
      img = {
        "#" => WALL_IMG,
        "@" => ROBOT_IMG,
        "O" => BOX_IMG,
        "[" => BOX_LEFT_IMG,
        "]" => BOX_RIGHT_IMG,
        "." => nil,
      }.fetch(GRID[y][x])
      next if img.nil?
      img.draw(x: x * CELL_SIZE - offset_x * CELL_SIZE, y: y * CELL_SIZE - offset_y * CELL_SIZE)
    end
  end
end

# Main draw loop
update do
  if get(:frames) % 6 == 0 && moves_idx < MOVES.length
    move = MOVES[moves_idx]
    if  can_move?(robot, move)
      move!(robot, move)
      robot[0] += move[0]
      robot[1] += move[1]
    end
    moves_idx += 1

    if moves_idx == MOVES.length
      part1 = 0

      HEIGHT.times do |r|
        WIDTH.times do |c|
          if GRID[r][c] == "O"
            part1 += r * 100 + c
          end
        end
      end

      puts part1
    end
  end

  clear
  draw_grid(offset_x, offset_y)
end

on :key_down do |event|
  case event.key
  when 'left' then offset_x -= 1
  when 'right' then offset_x += 1
  when 'up' then offset_y -= 1
  when 'down' then offset_y += 1
  end
end

show
