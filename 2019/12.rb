class Moon
  def initialize(x, y, z)
    @x, @y, @z = x, y, z
    @vx = @vy = @vz = 0
  end

  attr_reader :x, :y, :z, :vx, :vy, :vz

  def total_energy
    potential_energy * kinetic_energy
  end

  def move
    @x += @vx
    @y += @vy
    @z += @vz
  end

  def increase_vx
    @vx += 1
  end

  def decrease_vx
    @vx -= 1
  end

  def increase_vy
    @vy += 1
  end

  def decrease_vy
    @vy -= 1
  end

  def increase_vz
    @vz += 1
  end

  def decrease_vz
    @vz -= 1
  end

  private

  def potential_energy
    @x.abs + @y.abs + @z.abs
  end

  def kinetic_energy
    @vx.abs + @vy.abs + @vz.abs
  end
end

class Gravity
  def apply(m1, m2)
    apply_x(m1, m2)
    apply_y(m1, m2)
    apply_z(m1, m2)
  end

  private

  def apply_x(m1, m2)
    moons = [m1, m2].sort_by(&:x)
    return if moons.map(&:x).uniq.length == 1

    moons.first.increase_vx
    moons.last.decrease_vx
  end

  def apply_y(m1, m2)
    moons = [m1, m2].sort_by(&:y)
    return if moons.map(&:y).uniq.length == 1

    moons.first.increase_vy
    moons.last.decrease_vy
  end

  def apply_z(m1, m2)
    moons = [m1, m2].sort_by(&:z)
    return if moons.map(&:z).uniq.length == 1

    moons.first.increase_vz
    moons.last.decrease_vz
  end
end

# moons = [
#   [-1, 0, 2],
#   [2, -10, -7],
#   [4, -8, 8],
#   [3, 5, -1]
# ].map { |pos| Moon.new(*pos) }

# moons = [
#   [-8, -10, 0],
#   [5, 5, 10],
#   [2, -7, 3],
#   [9, -8, -3]
# ].map { |pos| Moon.new(*pos) }

g = Gravity.new

prev_x_states = {}
prev_y_states = {}
prev_z_states = {}

moons = [
  [17,   5,  1],
  [-2,  -8,  8],
  [ 7,  -6, 14],
  [ 1, -10,  4]
].map { |pos| Moon.new(*pos) }

lcm = 1

999_999_999.times do |step|
  moons.combination(2).each { |moons| g.apply(*moons) }
  moons.each(&:move)

  x_state = moons.map { |m| [m.x, m.vx] }

  if prev_x_states.key?(x_state)
    lcm = lcm.lcm(step)
    break
  else
    prev_x_states[x_state] = true
  end
end

moons = [
  [17,   5,  1],
  [-2,  -8,  8],
  [ 7,  -6, 14],
  [ 1, -10,  4]
].map { |pos| Moon.new(*pos) }

999_999_999.times do |step|
  moons.combination(2).each { |moons| g.apply(*moons) }
  moons.each(&:move)

  y_state = moons.map { |m| [m.y, m.vy] }

  if prev_y_states.key?(y_state)
    lcm = lcm.lcm(step)
    break
  else
    prev_y_states[y_state] = true
  end
end

moons = [
  [17,   5,  1],
  [-2,  -8,  8],
  [ 7,  -6, 14],
  [ 1, -10,  4]
].map { |pos| Moon.new(*pos) }

999_999_999.times do |step|
  moons.combination(2).each { |moons| g.apply(*moons) }
  moons.each(&:move)

  z_state = moons.map { |m| [m.z, m.vz] }

  if prev_z_states.key?(z_state)
    lcm = lcm.lcm(step)
    break
  else
    prev_z_states[z_state] = true
  end
end

puts lcm
