require 'set'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

MOVEMENT = { "U" => [0, -1], "D" => [0, 1], "R" => [1, 0], "L" => [-1, 0] }

def move(head, dir)
  head.zip(MOVEMENT.fetch(dir)).map { |a, b| a + b }
end

def follow(knot1, knot2)
  dist = knot1.zip(knot2).map { |a, b| a - b }

  if dist.all? { _1.abs < 2 }
    knot2
  else
    knot2.zip(dist).map { |a, b| a + (b <=> 0) }
  end
end

def simulate(knots)
  rope = Array.new(knots) { [0, 0] }

  visited = Set.new
  visited.add(rope.last)

  INPUT.each do |line|
    dir, count = line.split

    count.to_i.times do
      rope.length.times do |idx|
        rope[idx] = idx < 1 ? move(rope[idx], dir) : follow(rope[idx-1], rope[idx])
      end

      visited.add(rope.last)
    end
  end

  visited.size
end

puts simulate(2)
puts simulate(10)
