INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def solve(lines, ignore_diagonals)
  lines.each_with_object(Hash.new(0)) do |((x1, y1), (x2, y2)), diagram|
    width, height = [(x2 - x1), (y2 - y1)]

    next if ignore_diagonals && width != 0 && height != 0

    dx, dy = [width <=> 0, height <=> 0]

    max = [width, height].map(&:abs).max
    (max + 1).times do |i|
      diagram[[x1 + i * dx, y1 + i * dy]] += 1
    end
  end.select { |k, v| v > 1 }.length
end

lines = INPUT.map do |line|
  line.split(" -> ").map { |p| p.split(",").map(&:to_i) }
end

puts solve(lines, true)
puts solve(lines, false)
