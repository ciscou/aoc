INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

x = 1
cycle = 0
signal_strengths = []

INPUT.each do |line|
  cycle += 1
  signal_strengths << cycle * x if (cycle - 20) % 40 == 0

  instruction, argument = line.split

  case instruction
  when "noop"
  when "addx"
    cycle += 1
    signal_strengths << cycle * x if (cycle - 20) % 40 == 0

    x += argument.to_i
  else
    raise "uh oh..."
  end
end

puts signal_strengths.sum
