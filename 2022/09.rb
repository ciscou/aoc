require 'set'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def simulate(knots)
  rope = knots.times.map { [0, 0] }

  visited = Set.new
  visited.add(rope.last)

  INPUT.each do |line|
    dir, count = line.split
    move = case dir
           when "U" then [ 0, -1]
           when "D" then [ 0,  1]
           when "R" then [ 1,  0]
           when "L" then [-1,  0]
           end

    count.to_i.times do
      head = rope.first
      head = head.zip(move).map { |a, b| a + b }

      rope[0] = head

      (1...rope.length).each do |tidx|
        h = rope[tidx - 1]
        t = rope[tidx]
        dist = h.zip(t).map { |a, b| a - b }

        touching = dist.all? { _1.abs < 2 }
        t = t.zip(dist).map { |a, b| a + (b <=> 0) } unless touching

        rope[tidx] = t
      end

      visited.add(rope.last)
    end
  end

  visited.size
end

puts simulate(2)
puts simulate(10)
