INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

TIMES = INPUT.first.split(":").last.strip.split.map(&:to_i)
DISTANCES = INPUT.last.split(":").last.strip.split.map(&:to_i)

part1 = 1
TIMES.length.times do |i|
  time = TIMES[i]
  distance = DISTANCES[i]
  min = 0.upto(time).find { _1 * (time - _1) > distance }
  max = time.downto(0).find { _1 * (time - _1) > distance }
  p [time, distance, min, max, max - min + 1]
  part1 *= max - min + 1
end
puts part1
