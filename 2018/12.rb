input = <<EOS
initial state: ##.##..#.#....#.##...###.##.#.#..###.#....##.###.#..###...#.##.#...#.#####.###.##..#######.####..#

.##.. => #
#...# => .
####. => #
##..# => #
..##. => .
.###. => .
..#.# => .
##### => .
##.#. => #
...## => #
.#.#. => .
##.## => #
#.##. => .
#.... => .
#..## => .
..#.. => #
.#..# => #
.#.## => #
...#. => .
.#... => #
###.# => #
#..#. => #
.#### => #
#.### => #
.##.# => #
#.#.. => .
###.. => #
..... => .
##... => .
....# => .
#.#.# => #
..### => #
EOS

input_lines = input.lines

initial_state = input.lines.shift.chomp[15..-1].split("")
input_lines.shift

transforms = {}
transforms.default = "."
input_lines.each do |line|
  line.chomp!

  a, b = line.split(" => ")
  transforms[a] = b
end

state = {}
state.default = "."
initial_state.each_with_index do |e, i|
  state[i] = e
end

last_val = nil
20.times do |gen|
  puts gen if gen % 1_000 == 0

  ids = state.keys
  min, max = ids.minmax

  next_state = {}
  (min-20..max+20).each_cons(5).each do |a, b, c, d, e|
    pattern = [a, b, c, d, e].map { |i| state[i] }
    res = transforms[pattern.join("")]
    # p [pattern, res] if pattern == [".", "#", ".", ".", "."]
    next_state[c] = res
  end

  state.clear
  next_state.each do |k, v|
    state[k] = v
  end

  res = state.sum do |k, v|
    v == "#" ? k : 0
  end

  puts "    #{gen.to_s.rjust(5, " ")} #{res} #{res - last_val unless last_val.nil?}"
  last_val = res
end

line = (-3..35).map do |i|
  state[i]
end
puts line.join("")

puts (50_000_000_000 - 158) * 81 + 11373
