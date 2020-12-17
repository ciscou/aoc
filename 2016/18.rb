input = ".^^^.^.^^^^^..^^^..^..^..^^..^.^.^.^^.^^....^.^...^.^^.^^.^^..^^..^.^..^^^.^^...^...^^....^^.^^^^^^^"

grid = []
grid << input.chars.map { |c| c == "^" }

while grid.length < 400000
  new_row = ([false] + grid.last + [false]).each_cons(3).map do |left, center, right|
    ( left &&  center && !right) ||
    (!left &&  center &&  right) ||
    ( left && !center && !right) ||
    (!left && !center && right)
  end

  grid << new_row
end

# grid.each do |row|
#   puts row.map { |c| c ? "^" : "." }.join("")
# end

p grid.length
p grid.map(&:length)
p grid.sum { |row| row.reject(&:itself).length }
