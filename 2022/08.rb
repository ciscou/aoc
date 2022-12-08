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
    [row,       0, 0,  1],
    [row, WIDTH-1, 0, -1],
  ].each do |r, c, dr, dc|
    xray(r, c, dr, dc, visible)
  end
end

WIDTH.times do |col|
  [
    [       0, col,  1, 0],
    [HEIGHT-1, col, -1, 0],
  ].each do |r, c, dr, dc|
    xray(r, c, dr, dc, visible)
  end
end

puts visible.size

def scenic_score_helper(r, c, dr, dc)
  res = 0
  highest = INPUT[r][c]

  r += dr
  c += dc

  while r >= 0 && c >= 0 && r < HEIGHT && c < WIDTH
    res += 1

    break unless INPUT[r][c] < highest

    r += dr
    c += dc
  end

  res
end

def scenic_score(r, c)
  scenic_score_helper(r, c,  1,  0) *
  scenic_score_helper(r, c, -1,  0) *
  scenic_score_helper(r, c,  0,  1) *
  scenic_score_helper(r, c,  0, -1)
end

highest_scenic_score = -1

HEIGHT.times do |r|
  WIDTH.times do |c|
    highest_scenic_score = [highest_scenic_score, scenic_score(r, c)].max
  end
end

puts highest_scenic_score
