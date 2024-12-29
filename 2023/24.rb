require "bigdecimal"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def calculate_intersection(h1, h2)
  x1, y1, _z1 = [h1[:pos][0]              , h1[:pos][1]              , h1[:pos][2]              ]
  x2, y2, _z2 = [h1[:pos][0] + h1[:vel][0], h1[:pos][1] + h1[:vel][1], h1[:pos][2] + h1[:vel][2]]
  x3, y3, _z3 = [h2[:pos][0]              , h2[:pos][1]              , h2[:pos][2]              ]
  x4, y4, _z4 = [h2[:pos][0] + h2[:vel][0], h2[:pos][1] + h2[:vel][1], h2[:pos][2] + h2[:vel][2]]

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

  true
end
puts part1
