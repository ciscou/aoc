INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

robots = INPUT.map do |line|
  p, v = line.split(" ")
  x, y = p.split("=").last.split(",").map(&:to_i)
  vx, vy = v.split("=").last.split(",").map(&:to_i)

  {
    x:,
    y:,
    vx:,
    vy:,
  }
end

w = 101
h = 103

robots.each do |r|
  r[:x] = (r[:x] + r[:vx] * 100) % w
  r[:y] = (r[:y] + r[:vy] * 100) % h
end

qs = { tl: 0, tr: 0, bl: 0, br: 0 }

robots.each do |r|
  q = nil
  q = :tl if r[:x] < w/2 && r[:y] < h/2
  q = :tr if r[:x] > w/2 && r[:y] < h/2
  q = :bl if r[:x] < w/2 && r[:y] > h/2
  q = :br if r[:x] > w/2 && r[:y] > h/2
  qs[q] += 1 if q
end

part1 = qs.values.reduce(:*)
puts part1
