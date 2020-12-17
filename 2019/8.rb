input = gets.chomp.chars.map(&:to_i)

width = 25
height = 6
size = width * height

layers = (input.length / size).times.map do |i|
  input[i * size, size]
end

final_image = [nil] * size

layers.reverse.each do |layer|
  layer.each_with_index do |pixel, i|
    next if pixel == 2
    final_image[i] = pixel
  end
end

final_image.each_slice(width).each do |row|
  puts row.map { |pixel| pixel == 1 ? "X" : " " }.join(" ")
end
