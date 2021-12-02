INPUT = File.read(__FILE__.sub('.rb', '.txt'))

class Submarine
  def initialize
    @depth = 0
    @horizontal_position = 0
    @aim = 0
  end

  attr_reader :depth, :horizontal_position, :aim

  def down(units)
    @aim += units
  end

  def up(units)
    @aim -= units
  end

  def forward(units)
    @horizontal_position += units
    @depth += units * @aim
  end
end

submarine = Submarine.new
submarine.instance_eval(INPUT)

puts submarine.horizontal_position * submarine.aim
puts submarine.horizontal_position * submarine.depth
