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

def calculate_max_dist(grid, dist, pos)
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

dist = {}
dist[start] = 0

part1 = calculate_max_dist(grid, dist, start)
puts part1

upscaled_grid = {}

INPUT.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    cell = if dist[[x, y]]
             case char
             when "|"
               [
                 [" ", "#", " "],
                 [" ", "#", " "],
                 [" ", "#", " "],
               ]
             when "-"
               [
                 [" ", " ", " "],
                 ["#", "#", "#"],
                 [" ", " ", " "],
               ]
             when "F", "S" # TODO: this S depends on the input
               [
                 [" ", " ", " "],
                 [" ", "#", "#"],
                 [" ", "#", " "],
               ]
             when "L"
               [
                 [" ", "#", " "],
                 [" ", "#", "#"],
                 [" ", " ", " "],
               ]
             when "J"
               [
                 [" ", "#", " "],
                 ["#", "#", " "],
                 [" ", " ", " "],
               ]
             when "7"
               [
                 [" ", " ", " "],
                 ["#", "#", " "],
                 [" ", "#", " "],
               ]
             else
               raise "unknown char #{char}"
             end
           else
             [
               [" ", " ", " "],
               [" ", ".", " "],
               [" ", " ", " "],
             ]
           end

    3.times do |dx|
      3.times do |dy|
        upscaled_grid[[3 * x + dx, 3 * y + dy]] = cell[dy][dx]
      end
    end
  end
end

# minx, maxx = upscaled_grid.keys.map(&:first).minmax
# miny, maxy = upscaled_grid.keys.map(&:last).minmax
# (miny..maxy).each do |y|
#   (minx..maxx).each do |x|
#     print upscaled_grid[[x, y]] || " "
#   end
#   puts
# end

def count_dots(grid, visited, x, y)
  return 0 if visited[[x, y]]
  visited[[x, y]] = true

  return 0 if grid[[x, y]] == "#"

  neighs = count_dots(grid, visited, x-1, y) +
           count_dots(grid, visited, x+1, y) +
           count_dots(grid, visited, x, y-1) +
           count_dots(grid, visited, x, y+1)

  if grid[[x, y]] == "."
    neighs + 1
  else
    neighs
  end
end

part2 = count_dots(upscaled_grid, {}, 200, 200) # TODO: this 200, 200 depends on the input
puts part2
