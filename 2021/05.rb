INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def solve(lines, ignore_diagonals)
  lines.each_with_object(Hash.new(0)) do |((x1, y1), (x2, y2)), diagram|
    next if ignore_diagonals && x1 != x2 && y1 != y2

    width_and_height = [x2 - x1, y2 - y1]
    dx, dy = width_and_height.map { |x| x <=> 0 }

    (width_and_height.map(&:abs).max + 1).times do |i|
      diagram[[x1 + i * dx, y1 + i * dy]] += 1
    end
  end.select { |k, v| v > 1 }.length
end

lines = INPUT.map { |l| l.split(" -> ").map { |p| p.split(",").map(&:to_i) } }

puts solve(lines, true)
puts solve(lines, false)
