require 'set'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)
HEIGHT = INPUT.length
WIDTH = INPUT.first.length

def xray(r, c, dr, dc, v)
  highest = -1

  while r >= 0 && c >= 0 && r < HEIGHT && c < WIDTH
    tree = INPUT[r][c].to_i
    if tree > highest
      v.add([r, c])
      highest = tree
    end

    r += dr
    c += dc
  end
end

visible = Set.new

HEIGHT.times do |row|
  [
    [row, 0, 0, 1],
    [row, WIDTH-1, 0, -1],
  ].each do |r, c, dr, dc|
    xray(r, c, dr, dc, visible)
  end
end

WIDTH.times do |col|
  [
    [0, col, 1, 0],
    [HEIGHT-1, col, -1, 0],
  ].each do |r, c, dr, dc|
    xray(r, c, dr, dc, visible)
  end
end

puts visible.size
