require_relative "../shared/utils"

class Part1BFS < BFS
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

class Part2BFS < BFS
  def initialize(machine)
    @machine = machine
    @seen = Set.new
  end

  def initial_state
    [@machine[:joltages].map { 0 }, []]
  end

  def visited?(state)
    joltages, _pressed = state

    !@seen.add?(joltages)
  end

  def neighbours(state)
    joltages, pressed = state

    @machine[:buttons].map do |buttons|
      next_joltages = joltages.dup
      buttons.each { next_joltages[it] += 1 }
      [next_joltages, pressed + [buttons]]
    end.reject do |next_joltages, _pressed|
      next_joltages.each_with_index.any? do |joltage, i|
        joltage > @machine[:joltages][i]
      end
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
  my_bfs = Part1BFS.new(machine)
  my_bfs.execute.each do |state|
    lights, pressed = state
    if lights == machine[:lights]
      part1 += pressed.length
      break
    end
  end
end

puts part1

part2 = 0

machines.each do |machine|
  my_bfs = Part2BFS.new(machine)
  my_bfs.execute.each do |state|
    joltages, pressed = state
    if joltages == machine[:joltages]
      part2 += pressed.length
      puts part2
      break
    end
  end
end

puts part2
