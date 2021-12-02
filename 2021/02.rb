INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def part1(commands)
  depth = 0
  horizontal_position = 0

  commands.each do |direction, units|
    case direction
    when "down"
      depth += units
    when "up"
      depth -= units
    when "forward"
      horizontal_position += units
    end
  end

  [depth, horizontal_position]
end

def part2(commands)
  aim = 0
  depth = 0
  horizontal_position = 0

  commands.each do |direction, units|
    case direction
    when "down"
      aim += units
    when "up"
      aim -= units
    when "forward"
      horizontal_position += units
      depth += aim * units
    end
  end

  [depth, horizontal_position]
end

commands = INPUT.map do |command|
  direction, units = command.split
  [direction, units.to_i]
end

puts part1(commands).inject(:*)
puts part2(commands).inject(:*)
