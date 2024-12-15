INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid_input, moves_input = INPUT.chunk { _1.empty? && nil }.map(&:last)

grid = grid_input.map do |line|
  line.chars
end

h = grid.length
w = grid.first.length

moves = moves_input.flat_map do |line|
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
h.times do |r|
  w.times do |c|
    if grid[r][c] == "@"
      robot = [r, c]
    end
  end
end

def can_move?(grid, pos, move)
  r, c = pos
  dr, dc = move
  nr = r + dr
  nc = c + dc

  case grid[nr][nc]
  when "."
    true
  when "#"
    false
  when "O"
    can_move?(grid, [nr, nc], move)
  end
end

def move!(grid, pos, move)
  r, c = pos
  dr, dc = move
  nr = r + dr
  nc = c + dc

  move!(grid, [nr, nc], move) unless grid[nr][nc] == "."
  grid[r][c], grid[nr][nc] = grid[nr][nc], grid[r][c] 
end

moves.each do |move|
  if can_move?(grid, robot, move)
    move!(grid, robot, move)
    robot[0] += move[0]
    robot[1] += move[1]
  end
end

part1 = 0

h.times do |r|
  w.times do |c|
    if grid[r][c] == "O"
      part1 += r * 100 + c
    end
  end
end

puts part1
