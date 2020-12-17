input = 265149

DIRECTION_TO_DELTA_POS = {
  0 => [ 1,  0], # right
  1 => [ 0, -1], # up
  2 => [-1,  0], # left
  3 => [ 0,  1]  # down
}

memory = Hash.new { |h, x| h[x] = Hash.new(0) }
memory[0][0] = 1

distance = 0
max_distance = 1
direction = 0
x = 0
y = 0

found = false
i = 2
loop do
  dx, dy = DIRECTION_TO_DELTA_POS[direction]

  x += dx
  y += dy

  sum = 0

  [-1, 0, 1].each do |dx|
    [-1, 0, 1].each do |dy|
      sum += memory[x + dx][y + dy]
    end
  end

  memory[x][y] = sum

  break if sum > input

  distance += 1

  if distance >= max_distance
    distance = 0

    direction += 1
    direction %= 4

    max_distance += 1 if direction.even?
  end

  i += 1
end

p memory[x][y]
