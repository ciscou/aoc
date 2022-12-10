INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

x = 1
cycle = 0
signal_strengths = []
crt = []

INPUT.each do |line|
  cycle += 1
  signal_strengths << cycle * x if (cycle - 20) % 40 == 0
  crt << ((((crt.length - 1) % 40) - (x - 1)).abs < 2)

  instruction, argument = line.split

  case instruction
  when "noop"
  when "addx"
    cycle += 1
    signal_strengths << cycle * x if (cycle - 20) % 40 == 0
    crt << ((((crt.length - 1) % 40) - (x - 1)).abs < 2)

    x += argument.to_i
  else
    raise "uh oh..."
  end
end

puts signal_strengths.sum
crt.each_slice(40).each do |row|
  puts row.map { |pixel| pixel ? "#" : " " }.join
end
