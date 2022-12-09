require 'set'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

head = [0, 0]
tail = [0, 0]

visited = Set.new
visited.add(tail.dup)

INPUT.each do |line|
  dir, count = line.split
  move = case dir
         when "U" then [ 0, -1]
         when "D" then [ 0,  1]
         when "R" then [ 1,  0]
         when "L" then [-1,  0]
         end

  count.to_i.times do
    head = head.zip(move).map { |a, b| a + b }
    dist = head.zip(tail).map { |a, b| a - b }

    touching = dist.all? { _1.abs < 2 }
    tail = tail.zip(dist).map { |a, b| a + (b <=> 0) } unless touching

    visited.add(tail.dup)
  end
end

puts visited.size
