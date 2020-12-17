class Moon
  def initialize(x, y, z)
    @x, @y, @z = x, y, z
    @vx = @vy = @vz = 0

    @initial_x = @x
    @initial_y = @y
    @initial_z = @z
    @initial_vx = @vx
    @initial_vy = @vy
    @initial_vz = @vz
  end

  attr_reader :x, :y, :z

  def matches_initial_state?
    @x == @initial_x &&
    @y == @initial_y &&
    @z == @initial_z &&
    @vx == @initial_vx &&
    @vy == @initial_vy &&
    @vz == @initial_vz
  end

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

moons = [
  [17,   5,  1],
  [-2,  -8,  8],
  [ 7,  -6, 14],
  [ 1, -10,  4]
].map { |pos| Moon.new(*pos) }

# moons = [
#   [-1, 0, 2],
#   [2, -10, -7],
#   [4, -8, 8],
#   [3, 5, -1]
# ].map { |pos| Moon.new(*pos) }

moons = [
  [-8, -10, 0],
  [5, 5, 10],
  [2, -7, 3],
  [9, -8, -3]
].map { |pos| Moon.new(*pos) }

g = Gravity.new

10000000.times do |step|
  moons.combination(2).each { |moons| g.apply(*moons) }
  moons.each(&:move)

  moons.each_with_index do |m, i|
    if m.matches_initial_state?
      puts "moon #{i} matches (#{step})"
    end
  end
end

puts moons.sum(&:total_energy)
