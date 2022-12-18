require 'set'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def adjacent(point)
  x, y, z = point

  [
    [x + 1, y, z],
    [x - 1, y, z],
    [x, y + 1, z],
    [x, y - 1, z],
    [x, y, z + 1],
    [x, y, z - 1],
  ]
end

droplets = INPUT.map { |line| line.split(",").map(&:to_i) }.to_set
minx, maxx = droplets.map { |d| d[0] }.minmax
miny, maxy = droplets.map { |d| d[1] }.minmax
minz, maxz = droplets.map { |d| d[2] }.minmax
bubbles = Set.new
air = Set.new
area1 = 0
area2 = 0

droplets.each do |droplet|
  adjacent(droplet).each do |neighbour|
    unless droplets.include?(neighbour)
      area1 += 1

      possible_bubbles = Set.new
      possible_bubbles.add(neighbour)
      stack = [neighbour]
      is_bubble = true

      until stack.empty?
        node = stack.pop
        x, y, z = node

        is_bubble = false if air.include?(node)
        is_bubble = false if x < minx
        is_bubble = false if x > maxx
        is_bubble = false if y < miny
        is_bubble = false if y > maxy
        is_bubble = false if z < minz
        is_bubble = false if z > maxz

        break unless is_bubble

        adjacent(node).each do |possible_bubble|
          next if droplets.include?(possible_bubble) || bubbles.include?(possible_bubble) || possible_bubbles.include?(possible_bubble)

          possible_bubbles.add(possible_bubble)
          stack.push(possible_bubble)
        end
      end

      if is_bubble
        bubbles.merge(possible_bubbles)
      else
        air.merge(possible_bubbles)
      end

      area2 += 1 unless bubbles.include?(neighbour)
    end
  end
end

puts area1
puts area2
