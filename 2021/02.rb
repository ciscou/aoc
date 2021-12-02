INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def part1(commands)
  commands_by_direction = commands.group_by(&:first)

  final_depth = commands_by_direction["down"].map(&:last).sum - commands_by_direction["up"].map(&:last).sum
  final_horizontal_position = commands_by_direction["forward"].map(&:last).sum

  [final_depth, final_horizontal_position]
end

def part2(commands)
  aim = 0
  depth = 0
  horizontal_position = 0

  commands.each do |command|
    direction, count = command
    case direction
    when "down"
      aim += count
    when "up"
      aim -= count
    when "forward"
      horizontal_position += count
      depth += aim * count
    end
  end

  [depth, horizontal_position]
end

commands = INPUT.map do |command|
  direction, count = command.split
  [direction, count.to_i]
end

puts part1(commands).inject(:*)
puts part2(commands).inject(:*)
