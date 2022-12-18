require 'set'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

droplets = INPUT.map { |line| line.split(",").map(&:to_i) }.to_set
bubbles = Set.new
area = 0

droplets.each do |droplet|
  x, y, z = droplet
  [
    [x + 1, y, z],
    [x - 1, y, z],
    [x, y + 1, z],
    [x, y - 1, z],
    [x, y, z + 1],
    [x, y, z - 1],
  ].each do |neighbour|
    if !droplets.include?(neighbour)
      area += 1
    end
  end
end

puts area
