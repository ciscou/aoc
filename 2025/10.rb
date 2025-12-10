require_relative "../shared/utils"

class MyBFS < BFS
  def initialize(machine)
    @machine = machine
    @seen = Set.new
  end

  def initial_state
    [@machine[:lights].map { false }, []]
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
      [next_lights, pressed + [buttons]]
    end
  end
end

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

machines = INPUT.map do |line|
  parts = line.split
  lights = parts[0][1..-2].chars.map { it == "#" }
  buttons = parts[1..-2].map { |button| button[1..-2].split(",").map(&:to_i) }
  joltages = parts[-1][1..-2].split(",").map(&:to_i)

  { lights:, buttons:, joltages: }
end

part1 = 0

machines.each do |machine|
  my_bfs = MyBFS.new(machine)
  my_bfs.execute.each do |state|
    lights, pressed = state
    if lights == machine[:lights]
      part1 += pressed.length
      break
    end
  end
end

puts part1
