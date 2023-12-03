INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def symbols_around(grid, x, y)
  res = []

  [-1, 0, 1].each do |dx|
    [-1, 0, 1].each do |dy|
      char = grid[[x + dx, y + dy]]
      unless %w[0 1 2 3 4 5 6 7 8 9 .].include?(char)
        res << {
          char: char,
          x: x + dx,
          y: y + dy,
        }
      end
    end
  end

  res
end

grid = Hash.new(".")
INPUT.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    grid[[x, y]] = char
  end
end

part1 = 0
symbols = Hash.new { |h, k| h[k] = { parts: [] } }

INPUT.length.times do |y|
  n = 0
  adj = Set.new

  (INPUT.first.length + 1).times do |x| # +1 to include right border numbers
    char = grid[[x, y]]
    if ("0".."9").include? char
      adj += symbols_around(grid, x, y)
      n *= 10
      n += char.to_i
    else
      part1 += n unless adj.empty?
      if n > 0
        adj.each do |sym|
          symbols[[sym[:x], sym[:y]]][:char] = sym[:char]
          symbols[[sym[:x], sym[:y]]][:parts] << n
        end
      end
      n = 0
      adj = Set.new
    end
  end
end

puts part1

part2 = 0

symbols.each_value do |sym|
  if sym[:char] == "*" && sym[:parts].length == 2
    part2 += sym[:parts].reduce(:*)
  end
end

puts part2
