INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

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

def partX(commands, submarine)
  commands.each do |direction, units|
    case direction
    when "down"
      submarine.down(units)
    when "up"
      submarine.up(units)
    when "forward"
      submarine.forward(units)
    end
  end

  submarine.depth * submarine.horizontal_position
end

commands = INPUT.map do |command|
  direction, units = command.split
  [direction, units.to_i]
end

puts partX(commands, SubmarinePart1.new)
puts partX(commands, SubmarinePart2.new)
