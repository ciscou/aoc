INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

points = INPUT.map do |line|
  eval("[#{line}]")
end

def manhattan(p1, p2)
  p1.zip(p2).sum { |a, b| (b - a).abs }
end

constellations = []

until points.empty? do
  point = points.shift

  adjacent_constellations = constellations.select do |constellation|
    constellation.any? { |p| manhattan(point, p) <= 3 }
  end

  if adjacent_constellations.any?
    constellations -= adjacent_constellations
    merged_constellation = adjacent_constellations.flatten(1)
    merged_constellation << point
    constellations << merged_constellation
  else
    constellations << [point]
  end
end

puts constellations.size
