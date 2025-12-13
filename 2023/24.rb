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
    pos: pos.split(", ").map(&:to_i),
    vel: vel.split(", ").map(&:to_i),
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

require "z3"

x, y, z, vx, vy, vz = %w[x y z vx vy vz].map { Z3::Int(it) }

solver = Z3::Solver.new

# solver.assert(x == 191537613659010) this comes from hailstones.take(3)
# solver.assert(y == 238270932096689) this comes from hailstones.take(3)
# solver.assert(z == 137106090006865) this comes from hailstones.take(3)

solver.assert(vx > -400)
solver.assert(vy > -400)
solver.assert(vz > -400)
solver.assert(vx < 400)
solver.assert(vy < 400)
solver.assert(vz < 400)

hailstones.each_with_index do |hailstone, i|
  t = Z3::Int(["t", i].join("_"))

  x_pos_at_t = Z3::Int(["x_pos_at_t", i].join("_"))
  y_pos_at_t = Z3::Int(["y_pos_at_t", i].join("_"))
  z_pos_at_t = Z3::Int(["z_pos_at_t", i].join("_"))

  solver.assert(x_pos_at_t == t * hailstone[:vel][0] + hailstone[:pos][0])
  solver.assert(y_pos_at_t == t * hailstone[:vel][1] + hailstone[:pos][1])
  solver.assert(z_pos_at_t == t * hailstone[:vel][2] + hailstone[:pos][2])

  solver.assert(x_pos_at_t == t * vx + x)
  solver.assert(y_pos_at_t == t * vy + y)
  solver.assert(z_pos_at_t == t * vz + z)
end

if solver.satisfiable?
  # puts solver.model[x].to_i
  # puts solver.model[y].to_i
  # puts solver.model[z].to_i
  # puts solver.model[vx].to_i
  # puts solver.model[vy].to_i
  # puts solver.model[vz].to_i

  # puts

  puts [
    solver.model[x].to_i,
    solver.model[y].to_i,
    solver.model[z].to_i,
  ].sum
else
  raise "uh oh..."
end
