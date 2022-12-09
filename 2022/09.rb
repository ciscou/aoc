require 'set'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def move(head, dir)
  hx, hy = head
  dx, dy = case dir
           when "U" then [ 0, -1]
           when "D" then [ 0,  1]
           when "R" then [ 1,  0]
           when "L" then [-1,  0]
           end

  [hx + dx, hy + dy]
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
        rope[idx] = if idx < 1
                      move(rope[idx], dir)
                    else
                      follow(rope[idx-1], rope[idx])
                    end
      end

      visited.add(rope.last)
    end
  end

  visited.size
end

puts simulate(2)
puts simulate(10)
