INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def solve(lines, ignore_diagonals)
  diagram = Hash.new(0)

  lines.each do |line|
    p1, p2 = line
    x1, y1 = p1
    x2, y2 = p2

    dx = (x2 - x1) <=> 0
    dy = (y2 - y1) <=> 0

    if ignore_diagonals
      next unless dx == 0 || dy == 0
    end

    loop do
      diagram[[x1, y1]] += 1

      break if x1 == x2 && y1 == y2

      x1 += dx
      y1 += dy
    end
  end

  puts diagram.select { |k, v| v > 1 }.length
end

lines = INPUT.map do |line|
  line.split(" -> ").map { |p| p.split(",").map(&:to_i) }
end

solve(lines, true)
solve(lines, false)
