INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

require_relative "../shared/utils"

class Part1BFS < BFS
  def initialize(machine)
    @machine = machine
    @seen = Set.new
  end

  def initial_state
    [@machine[:lights].map { false }, 0]
  end

  def visited?(state)
    lights, _pressed = state

    !@seen.add?(lights)
  end

  def neighbours(state)
    lights, pressed = state

    @machine[:buttons].map do |buttons|
      next_lights = lights.dup
      buttons.each { next_lights[it] = !next_lights[it] }
      [next_lights, pressed + 1]
    end
  end
end

machines = INPUT.map do |line|
  parts = line.split
  lights = parts[0][1..-2].chars.map { it == "#" }
  buttons = parts[1..-2].map { |button| button[1..-2].split(",").map(&:to_i) }
  joltages = parts[-1][1..-2].split(",").map(&:to_i)

  { lights:, buttons:, joltages: }
end

part1 = 0

machines.each do |machine|
  Part1BFS.new(machine).execute.each do |state|
    lights, pressed = state

    if lights == machine[:lights]
      part1 += pressed
      break
    end
  end
end

puts part1

part2 = machines.sum do |machine|
  File.open("10p2.dat", "w") do |f|
    f.puts "set counters := #{machine[:joltages].length.times.map { "c#{it}" }.join(" ")};"
    f.puts "set buttons := #{machine[:buttons].length.times.map { "b#{it}" }.join(" ")};"

    f.puts

    f.puts "param: goal_joltages :="
    machine[:joltages].each_with_index do |joltage, i|
      f.puts "  #{"c#{i}"} #{joltage}"
    end
    f.puts ";"

    f.puts

    f.puts "param button_joltages (tr):"
    f.puts "     #{machine[:joltages].length.times.map { "c#{it}" }.join(" ")} :="
    machine[:buttons].each_with_index do |button, i|
      joltages = machine[:joltages].length.times.map { button.include?(it) ? 1 : 0 }
      f.puts "  #{["b", i].join}  #{joltages.join("  ")}"
    end
    f.puts ";"
  end

  `glpsol --model 10p2.mod --data 10p2.dat --write 10p2.out`

  File.readlines("10p2.out")[5][30..].to_i
end

puts part2
