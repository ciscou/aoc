INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def monitor_signal_strenght(signal_strengths, cycle, x)
  signal_strengths << cycle * x if (cycle - 20) % 40 == 0
end

def draw_pixel(crt, sprite)
  pixel = crt.length % 40
  crt << ((pixel - sprite).abs < 2)
end

x = 1
cycle = 0
signal_strengths = []
crt = []

INPUT.each do |line|
  cycle += 1
  monitor_signal_strenght(signal_strengths, cycle, x)
  draw_pixel(crt, x)

  instruction, argument = line.split

  case instruction
  when "noop"
  when "addx"
    cycle += 1
    monitor_signal_strenght(signal_strengths, cycle, x)
    draw_pixel(crt, x)

    x += argument.to_i
  else
    raise "uh oh..."
  end
end

puts signal_strengths.sum
crt.each_slice(40).each do |row|
  puts row.map { |pixel| pixel ? "#" : " " }.join
end
