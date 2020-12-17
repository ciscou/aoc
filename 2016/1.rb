input = "R2, L3, R2, R4, L2, L1, R2, R4, R1, L4, L5, R5, R5, R2, R2, R1, L2, L3, L2, L1, R3, L5, R187, R1, R4, L1, R5, L3, L4, R50, L4, R2, R70, L3, L2, R4, R3, R194, L3, L4, L4, L3, L4, R4, R5, L1, L5, L4, R1, L2, R4, L5, L3, R4, L5, L5, R5, R3, R5, L2, L4, R4, L1, R3, R1, L1, L2, R2, R2, L3, R3, R2, R5, R2, R5, L3, R2, L5, R1, R2, R2, L4, L5, L1, L4, R4, R3, R1, R2, L1, L2, R4, R5, L2, R3, L4, L5, L5, L4, R4, L2, R1, R1, L2, L3, L2, R2, L4, R3, R2, L1, L3, L2, L4, L4, R2, L3, L3, R2, L4, L3, R4, R3, L2, L1, L4, R4, R2, L4, L4, L5, L1, R2, L5, L2, L3, R2, L2"

directions = input.split(", ").map do |s|
  d = s.slice!(0)

  [d == "R" ? 1 : -1, s.to_i]
end

def follow(directions)
  x = 0
  y = 0

  facing = 0 # [north, east, south, west]

  visited = Hash.new { |h, k| h[k] = {} }
  visited[0][0] = true

  directions.each do |d, l|
    facing += d # L: -1, R: +1
    facing %= 4

    dx = 0
    dy = 0

    case facing
    when 0 then dy = -1
    when 1 then dx =  1
    when 2 then dy =  1
    when 3 then dx = -1
    else raise "invalid"
    end

    l.times do
      x += dx
      y += dy

      return [x, y] if visited[x][y]
      visited[x][y] = true
    end

  end

  [x, y]
end

x, y = follow(directions)
puts x.abs + y.abs
