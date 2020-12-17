input = File.read("13.txt")

grid = []

input.lines.each do |line|
  line.chomp!

  grid << line.chars
end

cars = []
collisions = {}
idx = 0

grid.each_with_index do |r, y|
  r.each_with_index do |c, x|
    case c
    when "^", "v"
      cars << { row: y, col: x, dir: c, turns: 0, idx: idx }
      grid[y][x] = "|"
      idx += 1
    when "<", ">"
      cars << { row: y, col: x, dir: c, turns: 0, idx: idx }
      grid[y][x] = "-"
      idx += 1
    end
  end
end

follow_car = cars[2]

steps = 0

loop do
  if steps > 190000000
    print "    "
    grid.first.each_with_index do |c, x|
      next unless x > follow_car[:col] - 40
      next unless x < follow_car[:col] + 40
      print " "
      print x / 100 % 1000
    end
    puts
    print "    "
    grid.first.each_with_index do |c, x|
      next unless x > follow_car[:col] - 40
      next unless x < follow_car[:col] + 40
      print " "
      print x / 10 % 100
    end
    puts
    print "    "
    grid.first.each_with_index do |c, x|
      next unless x > follow_car[:col] - 40
      next unless x < follow_car[:col] + 40
      print " "
      print x / 1 % 10
    end
    puts
    grid.each_with_index do |r, y|
      next unless y > follow_car[:row] - 20
      next unless y < follow_car[:row] + 20
      print y.to_s.rjust(3, " ")
      print " "
      r.each_with_index do |c, x|
        next unless x > follow_car[:col] - 40
        next unless x < follow_car[:col] + 40
        car = cars.detect { |c| c[:col] == x && c[:row] == y }
        collision = collisions[[y, x]]
        print " "
        print(if car
                "\e[32m#{car[:dir]}\e[0m"
              elsif collision
                "\e[31mX\e[0m"
              else
                c
              end)
      end
      puts
    end
    gets
  end

  collided_cars = []

  cars.sort_by { |c| [c[:row], c[:col]] }.each do |car|
    next if collided_cars.include?(car)

    case car[:dir]
    when "^"
      car[:row] -= 1
    when "v"
      car[:row] += 1
    when "<"
      car[:col] -= 1
    when ">"
      car[:col] += 1
    else
      raise "uh oh..."
    end

    case grid[car[:row]][car[:col]]
    when "-", "|"
      # straight
    when "/"
      h = { "^" => ">", "v" => "<", "<" => "v", ">" => "^"  }
      car[:dir] = h[car[:dir]]
    when "\\"
      h = { "^" => "<", "v" => ">", "<" => "^", ">" => "v"  }
      car[:dir] = h[car[:dir]]
    when "+"
      hs = [
        { "^" => "<", "v" => ">", "<" => "v", ">" => "^"  },
        { "^" => "^", "v" => "v", "<" => "<", ">" => ">"  },
        { "^" => ">", "v" => "<", "<" => "^", ">" => "v"  }
      ]
      h = hs[car[:turns] % hs.length]
      car[:dir] = h[car[:dir]]
      car[:turns] += 1
    else
      raise "uh oh... #{car.inspect}"
    end

    other_cars = cars.select do |other_car|
      car[:idx] != other_car[:idx] &&
      car[:row] == other_car[:row] &&
      car[:col] == other_car[:col]
    end

    if other_cars.any?
      collided_cars << car
      other_cars.each { |other_car| collided_cars << other_car }
    end
  end

  collided_cars.each do |car|
    p [steps, car]
    cars.delete(car)
    collisions[[car[:row], car[:col]]] = true
  end

  break if cars.length < 2

  steps += 1
end

print "    "
grid.first.each_with_index do |c, x|
  next unless x > follow_car[:col] - 40
  next unless x < follow_car[:col] + 40
  print " "
  print x / 100 % 1000
end
puts
print "    "
grid.first.each_with_index do |c, x|
  next unless x > follow_car[:col] - 40
  next unless x < follow_car[:col] + 40
  print " "
  print x / 10 % 100
end
puts
print "    "
grid.first.each_with_index do |c, x|
  next unless x > follow_car[:col] - 40
  next unless x < follow_car[:col] + 40
  print " "
  print x / 1 % 10
end
puts
grid.each_with_index do |r, y|
  next unless y > follow_car[:row] - 20
  next unless y < follow_car[:row] + 20
  print y.to_s.rjust(3, " ")
  print " "
  r.each_with_index do |c, x|
    next unless x > follow_car[:col] - 40
    next unless x < follow_car[:col] + 40
    car = cars.detect { |c| c[:col] == x && c[:row] == y }
    collision = collisions[[y, x]]
    print " "
    print(if car
            "\e[32m#{car[:dir]}\e[0m"
          elsif collision
            "\e[31mX\e[0m"
          else
            c
          end)
  end
  puts
end
gets

collisions.keys.each { |c| p c }
cars.each { |c| p c }
