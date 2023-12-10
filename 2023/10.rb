INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = {}
start = nil

INPUT.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    start = [x, y] if char == "S"
    cell = case char
           when "." then []
           when "|" then [[ 0, -1], [ 0,  1]]
           when "-" then [[-1,  0], [ 1,  0]]
           when "F" then [[ 1,  0], [ 0,  1]]
           when "L" then [[ 1,  0], [ 0, -1]]
           when "J" then [[-1,  0], [ 0, -1]]
           when "7" then [[-1,  0], [ 0,  1]]
           when "S" then [[ 1,  0], [ 0,  1]] # TODO: this depends on the input
           else raise "unknown char #{char}"
           end

    grid[[x, y]] = cell
  end
end

def calculate_max_dist(grid, pos)
  dist = {}
  dist[pos] = 0

  queue = [pos]
  max_dist = 0

  until queue.empty?
    x, y = queue.shift

    grid[[x, y]].each do |dx, dy|
      if dist[[x + dx, y + dy]].nil?
        dist[[x + dx, y + dy]] = dist[[x, y]] + 1
        queue << [x + dx, y + dy]
        max_dist = [max_dist, dist[[x + dx, y + dy]]].max
      end
    end
  end

  max_dist
end

part1 = calculate_max_dist(grid, start)
puts part1
