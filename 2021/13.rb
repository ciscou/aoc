INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

points = {}
folds = []

INPUT.each do |line|
  next if line.empty?

  if line.start_with?("fold along ")
    fold = line.split(" ").last
    axis, n = fold.split("=")

    folds << [axis, n.to_i]
  else
    points[line.split(",").map(&:to_i)] = true
  end
end

part1 = true

folds.each do |axis, n|
  case axis
  when "x"
    points.keys.select { |x, y| x < n }.each do |point|
      x, y = point

      points.delete(point)
      points[[2 * n - x, y]] = true
    end

    new_points = {}

    points.keys.each do |x, y|
      new_points[[x - n - 1, y]] = true
    end

    points = new_points
  when "y"
    points.keys.select { |x, y| y > n }.each do |point|
      x, y = point

      points.delete(point)
      points[[x, 2 * n - y]] = true
    end
  else
    raise "invalid axis #{axis.inspect}"
  end

  puts points.size if part1
  part1 = false
end

6.times do |y|
  line = 40.times.map do |x|
    points[[x, y]] ? "#" : "."
  end

  puts line.join("").reverse
end
