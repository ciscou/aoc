input = <<EOS
################################
##########################..####
#########################...####
#########################..#####
########################G..#####
#####################.#.....##.#
#####################..........#
##############.#####...........#
########G...G#.####............#
#######......G....#.....#......#
#######...G....GG.#............#
#######G.G.............####....#
#######.#.....#####....E.....###
#######......#######.G.......###
#..####..G..#########.###..#####
#........G..#########.##########
#..#..#G....#########.##########
#.###...E...#########.##########
#####...G.G.#########.##########
########G....#######..##########
####..........#####...##########
####......E........G..##########
#.G..................###########
#G...................###########
###.....##E.......E..###########
###....#............############
###.................############
##G.....#.............##########
###########...#E..##..##########
###########.E...###.E.EE.#######
###########......#.......#######
################################
EOS

# input = <<EOS
# #######
# #.G...#
# #...EG#
# #.#.#G#
# #..G#E#
# #.....#
# #######
# EOS

# input = <<EOS
# #######
# #G..#E#
# #E#E.E#
# #G.##.#
# #...#E#
# #...E.#
# #######
# EOS

# input = <<EOS
# #######
# #E..EG#
# #.#G.E#
# #E.##E#
# #G..#.#
# #..E#.#
# #######
# EOS

# input = <<EOS
# #######
# #E.G#.#
# #.#G..#
# #G.#.G#
# #G..#.#
# #...E.#
# #######
# EOS

# input = <<EOS
# #######
# #.E...#
# #.#..G#
# #.###.#
# #E#G#G#
# #...#G#
# #######
# EOS

# input = <<EOS
# #########
# #G......#
# #.E.#...#
# #..##..G#
# #...##..#
# #...#...#
# #.G...G.#
# #.....G.#
# #########
# EOS

def adjacent_to_target?(grid, unit, row, col)
  [
    [-1,  0],
    [ 0, -1],
    [ 0,  1],
    [ 1,  0]
  ].any? do |mov|
    drow, dcol = mov
    cell = grid[row + drow][col + dcol]

    %w[E G].any? { |type| cell == type } && (cell != unit[:type])
  end
end

def adjacent_targets(grid, units, unit)
  row = unit[:row]
  col = unit[:col]

  [
    [-1,  0],
    [ 0, -1],
    [ 0,  1],
    [ 1,  0]
  ].map do |mov|
    drow, dcol = mov
    cell = grid[row + drow][col + dcol]

    if %w[E G].any? { |type| cell == type } && (cell != unit[:type])
      units.detect { |u| (u[:row] == row + drow) && (u[:col] == col + dcol) }
    end
  end.compact
end

def move_towards_target(grid, unit)
  optimal_paths = []
  visited = Hash.new { |h, k| h[k] = [] }
  queue = []

  visited[unit[:row]][unit[:col]] = true
  queue.push([unit[:row], unit[:col], []])

  until queue.empty?
    node = queue.shift
    row, col, path = node

    if adjacent_to_target?(grid, unit, row, col)
      optimal_paths << path
    else
      [
        [-1,  0],
        [ 0, -1],
        [ 0,  1],
        [ 1,  0]
      ].each do |mov|
        drow, dcol = mov

        if !visited[row + drow][col + dcol] && grid[row + drow][col + dcol] == "."
          visited[row + drow][col + dcol] = true
          queue.push([row + drow, col + dcol, path + [mov]])
        end
      end
    end
  end

  if optimal_paths.empty?
    # no solution
  elsif optimal_paths.all?(&:empty?)
    # already next to target
  else
    optimal_paths.sort_by! do |path|
      target = path.inject([unit[:row], unit[:col]]) do |a, e|
        row, col = a
        drow, dcol = e

        [row + drow, col + dcol]
      end

      [path.length, target, path.first]
    end

    # optimal_paths.each { |op| p op }

    drow, dcol = optimal_paths.first.first
    grid[unit[:row]][unit[:col]], grid[unit[:row] + drow][unit[:col] + dcol] = ".", unit[:type]
    unit[:row], unit[:col] = unit[:row] + drow, unit[:col] + dcol
  end
end

elves_attack_power_min = 4
elves_attack_power_max = 100

until (elves_attack_power_max - elves_attack_power_min).abs < 2
  elves_attack_power = (elves_attack_power_min + elves_attack_power_max) / 2

  grid = Hash.new { |h, k| h[k] = Hash.new("#") }

  grid = input.lines.map do |line|
    line.chomp!

    line.chars
  end

  units = []

  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      if %w[E G].include?(cell)
        units << { row: y, col: x, type: cell, hit_points: 200, attack_power: cell == "E" ? elves_attack_power : 3 }
      end
    end
  end
  elves_total = units.select { |u| u[:type] == "E" }.length

  rounds = 0
  until units.map { |u| u[:type] }.sort.uniq.size < 2
    full_round = true

    # puts rounds
    # p units.select { |e| e[:type] == "E" }

    # puts
    # puts
    # puts
    # grid.each do |row|
    #   puts row.join(" ")
    # end
    # gets

    round_units = []
    units.each { |u| round_units << u }
    round_units.sort_by! { |u| [[u[:row], u[:col]]] }

    until round_units.empty?
      full_round = false if units.map { |u| u[:type] }.sort.uniq.size < 2

      unit = round_units.shift

      # puts
      # puts
      # puts
      # puts "before:"
      # puts
      # grid.each_with_index do |row, y|
      #   row.each_with_index do |cell, x|
      #     print " "
      #     if y == unit[:row] && x == unit[:col]
      #       print "\e[32m#{cell}\e[0m"
      #     else
      #       print cell
      #     end
      #   end
      #   puts
      # end
      # gets

      move_towards_target(grid, unit)
      targets = adjacent_targets(grid, units, unit)
      targets.sort_by! { |u| [u[:hit_points], u[:row], u[:col]] }
      # p targets
      target = targets.first
      if target
        # puts "#{unit.inspect} attacks #{target.inspect}"
        target[:hit_points] -= unit[:attack_power]
        if target[:hit_points] <= 1
          grid[target[:row]][target[:col]] = "."
          units.delete(target)
          round_units.delete(target)
        end
      end

      # puts
      # puts
      # puts
      # puts "after:"
      # puts
      # grid.each_with_index do |row, y|
      #   row.each_with_index do |cell, x|
      #     print " "
      #     if y == unit[:row] && x == unit[:col]
      #       print "\e[32m#{cell}\e[0m"
      #     else
      #       print cell
      #     end
      #   end
      #   puts
      # end
      # gets
    end

    rounds += 1 if full_round
  end

  # puts
  # puts
  # puts
  # grid.each do |row|
  #   puts row.join(" ")
  # end

  # units.each { |u| p u }

  # puts rounds
  # puts units.sum { |u| u[:hit_points] }

  elves_win = (units.length == elves_total) && units.first[:type] == "E"
  if elves_win
    elves_attack_power_max = elves_attack_power
    puts rounds * units.sum { |u| u[:hit_points] }
  else
    elves_attack_power_min = elves_attack_power
  end
end
