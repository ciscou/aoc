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

def part2_backtracking(buttons, joltages, goal, offset=0, cache={})
  cache_key = [goal, offset]
  if cache.key?(cache_key)
    return cache[cache_key]
  end
  return 0 if goal.uniq == [0]
  return Float::INFINITY if goal.any? { it < 0 }
  return Float::INFINITY if offset >= buttons.length

  next_goal = goal.dup
  buttons[offset].each { next_goal[it] -= 1 }

  cache[cache_key] = [
    part2_backtracking(buttons, joltages, goal, offset + 1, cache), # do not press this button
    part2_backtracking(buttons, joltages, next_goal, offset, cache) + 1, # press this button
  ].min
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
      part1 += pressed
      break
    end
  end
end

puts part1

if false
machines.each do |machine|
  is = []

  machine[:buttons].each do |buttons|
    joltages = machine[:joltages].dup
    i = 0

    loop do
      break if joltages.any?(&:negative?)

      buttons.each { joltages[it] -= 1 }
      i += 1
    end

    is << i
  end

  puts is.reduce(:*)
end

puts "here it comes"

part2 = 0

machines.each do |machine|
  kk = part2_backtracking(machine[:buttons], machine[:joltages].map { 0 }, machine[:joltages])
  puts kk
  part2 += kk
end

puts part2

exit(0)
end

part2 = 0

LETTERS = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]

machines.each do |machine|
  equations = machine[:joltages].map.with_index do |joltage, i|
    [
      machine[:buttons].filter_map.with_index { |b, j| LETTERS[j] if b.include?(i) }.join(" + "),
      joltage
    ].join(" = ")
  end
  # puts equations
  # response = Faraday.post("https://www.symbolab.com/pub_api/bridge/solution", query: equations.join(", "))
  # puts JSON.parse(response.body).dig("solution", "solution", "default")
  # puts
  # gets

  File.open("10.mod", "w") do |f|
    variables = LETTERS.take(machine[:buttons].length)
    variables.each { f.puts "var #{it} >= 0, integer;" }
    equations.each_with_index do |eq, i|
      f.puts "s.t. eq#{i}: #{eq};"
    end
    f.puts "minimize obj: #{variables.join("+")};"
    f.puts "solve;"
    f.puts %(printf "%g\\n", #{variables.join("+")};)
    f.puts "end;"
  end

  output = `glpsol --model 10.mod`
  part2 += output.lines[-2].to_i

  # gets
end

puts part2

exit(0)

part2 = 0

machines.each do |machine|
  part2 += part2_backtracking(machine[:buttons], machine[:joltages].map { 0 }, machine[:joltages])
end

puts part2
