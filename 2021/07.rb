INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def solve(crabs, &cost)
  (crabs.min..crabs.max).map do |pos|
    crabs.sum do |crab| 
      cost.call((crab - pos).abs)
    end
  end.min
end

def part1(crabs)
  solve(crabs) { |dist| dist }
end

def part2(crabs)
  solve(crabs) { |dist| (dist * (dist + 1)) / 2}
end

crabs = INPUT.first.split(",").map(&:to_i)

puts part1(crabs)
puts part2(crabs)
