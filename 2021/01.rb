INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def increases(measurements)
  measurements.each_cons(2).count { |a, b| b > a }
end

puts increases(INPUT.map(&:to_i))
puts increases(INPUT.map(&:to_i).each_cons(3).map(&:sum))
