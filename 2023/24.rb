require "bigdecimal"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def calculate_intersection(h1, h2)
  x1, y1, z1 = [h1[:pos][0]              , h1[:pos][1]              , h1[:pos][2]              ]
  x2, y2, z2 = [h1[:pos][0] + h1[:vel][0], h1[:pos][1] + h1[:vel][1], h1[:pos][2] + h1[:vel][2]]
  x3, y3, z3 = [h2[:pos][0]              , h2[:pos][1]              , h2[:pos][2]              ]
  x4, y4, z4 = [h2[:pos][0] + h2[:vel][0], h2[:pos][1] + h2[:vel][1], h2[:pos][2] + h2[:vel][2]]

  deno = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
  num1 = (x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)
  num2 = (x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)

  return nil if deno == 0

  [
    num1 / deno,
    num2 / deno,
    nil,
  ]
end

hailstones = INPUT.map do |line|
  pos, vel = line.split(" @ ")
  {
    pos: pos.split(", ").map { BigDecimal(_1) },
    vel: vel.split(", ").map { BigDecimal(_1) },
  }
end

intersections = {}

hailstones.each_with_index do |h1, i|
  hailstones.each_with_index do |h2, j|
    next unless j > i

    intersections[[i, j]] = calculate_intersection(h1, h2)
  end
end

def very_close(a, b)
  ratio = a / b
  (0.9999..1.0001).include?(a/b)
end

def crossed_in_the_past?(h, x, y, z)
  ns = (x - h[:pos][0]) / h[:vel][0]
  ns < 0
end

# MIN=7
# MAX=27
MIN=200000000000000
MAX=400000000000000

part1 = intersections.count do |k, v|
  next false if v.nil?

  i, j = k
  x, y, z = v
  next false if crossed_in_the_past?(hailstones[i], x, y, z)
  next false if crossed_in_the_past?(hailstones[j], x, y, z)
  next false unless (MIN..MAX).include?(x)
  next false unless (MIN..MAX).include?(y)
  puts
  elapsed = (x - hailstones[i][:pos][0]) / hailstones[i][:vel][0]
  z = hailstones[i][:pos][2] + elapsed * hailstones[i][:vel][2]
  p [i, j, x, y, z, elapsed]
  puts
  true
end
puts part1
