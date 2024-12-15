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

def can_move?(grid, pos, move, other: false)
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
  when "["
    if dr == 0 || other
      can_move?(grid, [nr, nc], move)
    else
      can_move?(grid, [nr, nc], move) && can_move?(grid, [r, c+1], move, other: true)
    end
  when "]"
    if dr == 0 || other
      can_move?(grid, [nr, nc], move)
    else
      can_move?(grid, [nr, nc], move) && can_move?(grid, [r, c-1], move, other: true)
    end
  else
    raise "wtf #{grid[nr][nc].inspect}"
  end
end

def move!(grid, pos, move, other: false)
  r, c = pos
  dr, dc = move
  nr = r + dr
  nc = c + dc

  move!(grid, [nr, nc], move) unless grid[nr][nc] == "."
  move!(grid, [r, c+1], move, other: true) if !other && grid[r][c] == "[" && dr != 0
  move!(grid, [r, c-1], move, other: true) if !other && grid[r][c] == "]" && dr != 0
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

grid = grid_input.map do |line|
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

h = grid.length
w = grid.first.length

robot = nil
h.times do |r|
  w.times do |c|
    if grid[r][c] == "@"
      robot = [r, c]
    end
  end
end

moves.each do |move|
  puts grid.map(&:join)
  puts

  if can_move?(grid, robot, move)
    move!(grid, robot, move)
    robot[0] += move[0]
    robot[1] += move[1]
  end
end

part2 = 0

h.times do |r|
  w.times do |c|
    if grid[r][c] == "["
      part2 += r * 100 + c
    end
  end
end

puts part2
