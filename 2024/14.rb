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

def display_robots(robots, w, h)
  grid = h.times.map { w.times.map { " " } }
  robots.each { grid[_1[:y]][_1[:x]] = "#" }
  if grid.any? { |l| l.join.include?("#####################") }
    puts grid.map(&:join)
    true
  else
    false
  end
end

elapsed = 0
loop do
  robots.each do |r|
    r[:x] = (r[:x] + r[:vx] * 1) % w
    r[:y] = (r[:y] + r[:vy] * 1) % h
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

  elapsed += 1

  # if qs[:tl] == qs[:tr] && qs[:bl] == qs[:br]
    if display_robots(robots, w, h)
      puts elapsed
      exit
    end
  # end

  puts elapsed if elapsed % 1_000_000 == 0

  if elapsed == 100
    puts qs.values.reduce(:*)
  end
end
