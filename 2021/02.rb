INPUT = File.read(__FILE__.sub('.rb', '.txt'))

class SubmarinePart1
  def initialize
    @depth = 0
    @horizontal_position = 0
  end

  attr_reader :depth, :horizontal_position

  def down(units)
    @depth += units
  end

  def up(units)
    @depth -= units
  end

  def forward(units)
    @horizontal_position += units
  end
end

class SubmarinePart2
  def initialize
    @depth = 0
    @horizontal_position = 0
    @aim = 0
  end

  attr_reader :depth, :horizontal_position

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

def partX(submarine)
  submarine.instance_eval(INPUT)

  submarine.depth * submarine.horizontal_position
end

puts partX(SubmarinePart1.new)
puts partX(SubmarinePart2.new)
