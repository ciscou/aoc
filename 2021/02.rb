INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

commands = INPUT.map do |command|
  direction, count = command.split
  [direction, count.to_i]
end

commands_by_direction = commands.group_by(&:first)

final_depth = commands_by_direction["down"].map(&:last).sum - commands_by_direction["up"].map(&:last).sum
final_horizontal_position = commands_by_direction["forward"].map(&:last).sum

puts final_depth * final_horizontal_position
