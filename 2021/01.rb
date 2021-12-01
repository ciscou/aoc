INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def increases(measurements, window_size = 1)
  measurements.each_cons(window_size + 1).count { |window| window.last > window.first }
end

puts increases(INPUT.map(&:to_i))
puts increases(INPUT.map(&:to_i), 3)
