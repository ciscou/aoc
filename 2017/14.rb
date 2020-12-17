input = "jxqlasbh"
# input = "flqrgnkx"

def knot_hash(s)
  numbers = 256.times.to_a
  current_position = 0
  skip_size = 0
  lengths = s.chars.map(&:ord)
  lengths += [17, 31, 73, 47, 23]

  64.times do
    lengths.each do |length|
      reversed_numbers = (numbers + numbers).slice(current_position, length).reverse
      reversed_numbers.each_with_index do |n, i|
        numbers[(current_position + i) % numbers.length] = n
      end

      current_position += length + skip_size
      skip_size += 1

      current_position %= numbers.length
    end
  end

  hash = numbers.each_slice(16).map { |slice| slice.inject(:^) }

  hash.map { |n| res = n.to_s(16).rjust(2, "0") }.join("")
end

grid = []

128.times do |i|
  hash = knot_hash("#{input}-#{i}")
  binary = hash.chars.map { |c| c.to_i(16).to_s(2).rjust(4, "0") }.join("")

  grid << binary.tr("01", ".#").split("")
end

res = grid.sum do |row|
  row.sum { |c| c == "#" ? 1 : 0 }
end

puts res

def mark_region_as_visited!(grid, row, col)
  return if row < 0
  return if row > 127
  return if col < 0
  return if col > 127

  return unless grid[row][col] == "#"
  grid[row][col] = "@"

  mark_region_as_visited!(grid, row-1, col)
  mark_region_as_visited!(grid, row+1, col)
  mark_region_as_visited!(grid, row, col-1)
  mark_region_as_visited!(grid, row, col+1)
end

regions = 0
found = true

while found
  found = false
  row = nil
  col = nil

  128.times do |r|
    128.times do |c|
      if grid[r][c] == "#"
        row = r
        col = c
        found = true
      end
    end
  end

  if found
    regions += 1
    mark_region_as_visited!(grid, row, col)
  end
end

puts regions
