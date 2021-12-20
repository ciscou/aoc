INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

algorithm = INPUT[0].chars

image = Hash.new(false)

INPUT[2..-1].each.with_index do |line, row|
  line.chars.each.with_index do |char, col|
    image[[row, col]] = char == "#"
  end
end

(1..50).each do |i|
  new_image = Hash.new(algorithm[0] == "#" ? !image.default : image.default)

  min_row, max_row = image.keys.map(&:first).minmax
  min_col, max_col = image.keys.map(&:last).minmax

  min_row -= 1
  min_col -= 1
  max_row += 1
  max_col += 1

  (min_row..max_row).each do |row|
    (min_col..max_col).each do |col|
      neighbours = ""
      neighbours << (image[[row-1, col-1]] ? "1" : "0")
      neighbours << (image[[row-1, col]] ? "1" : "0")
      neighbours << (image[[row-1, col+1]] ? "1" : "0")
      neighbours << (image[[row, col-1]] ? "1" : "0")
      neighbours << (image[[row, col]] ? "1" : "0")
      neighbours << (image[[row, col+1]] ? "1" : "0")
      neighbours << (image[[row+1, col-1]] ? "1" : "0")
      neighbours << (image[[row+1, col]] ? "1" : "0")
      neighbours << (image[[row+1, col+1]] ? "1" : "0")

      n = neighbours.to_i(2)

      new_image[[row, col]] = algorithm[n] == "#"
    end
  end

  image = new_image

  puts image.values.select(&:itself).size if i == 2 || i == 50
end
