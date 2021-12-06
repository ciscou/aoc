INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def evolve(days)
  ([0] * 9).tap do |population|
    INPUT.map(&:to_i).each { |n| population[n] += 1 }

    days.times do
      spawn = population.shift
      population[6] += spawn
      population[8] = span
    end
  end
end

puts evolve(80).sum
puts evolve(256).sum
