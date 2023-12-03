INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def symbol_around?(grid, x, y)
  [-1, 0, 1].each do |dx|
    [-1, 0, 1].each do |dy|
      unless %w[0 1 2 3 4 5 6 7 8 9 .].include?(grid[[x + dx, y + dy]])
        return true
      end
    end
  end

  false
end

grid = Hash.new(".")
INPUT.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    grid[[x, y]] = char
  end
end

part1 = 0

INPUT.length.times do |y|
  n = 0
  adj = false

  (INPUT.first.length + 1).times do |x| # +1 to include right border numbers
    char = grid[[x, y]]
    if ("0".."9").include? char
      adj ||= symbol_around?(grid, x, y)
      n *= 10
      n += char.to_i
    else
      part1 += n if adj
      n = 0
      adj = false
    end
  end
end

puts part1
