def calculate_points(segments)
  res = []
  x = 0
  y = 0

  segments.each do |segment|
    direction = segment[0]
    distance  = segment[1..-1].to_i

    dx = 0
    dy = 0

    case direction
    when "U" then dy =  1
    when "D" then dy = -1
    when "L" then dx = -1
    when "R" then dx =  1
    end

    distance.times do |i|
      x += dx
      y += dy

      res << [x, y]
    end
  end

  res
end

segments1 = gets.chomp.split(",")
segments2 = gets.chomp.split(",")

cable1 = calculate_points(segments1)
cable2 = calculate_points(segments2)

crosses = cable1 & cable2
crosses = crosses.map { |x| { x: x.first, y: x.last, steps: cable1.index(x) + cable2.index(x) + 2 } }
p crosses.sort_by { |x| x[:steps] }.first
