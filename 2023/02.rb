INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

games = Hash.new { |h, k| h[k] = [] }

INPUT.each do |line|
  game, subsets = line.split(": ")
  game_id = game.split(" ").last.to_i
  subsets = subsets.split("; ")
  subsets.each do |subset|
    games[game_id] << Hash.new(0)
    cubes = subset.split(", ")
    cubes.map(&:split).each do |number, color|
      games[game_id].last[color] = number.to_i
    end
  end
end

part1 = games.sum do |game_id, subsets|
  next 0 unless subsets.all? do |subset|
    subset["red"] <= 12 && subset["green"] <= 13 && subset["blue"] <= 14
  end

  game_id
end
puts part1

part2 = games.values.sum do |subsets|
  min_red = subsets.map { _1["red"] }.max
  min_green = subsets.map { _1["green"] }.max
  min_blue = subsets.map { _1["blue"] }.max

  min_red * min_green * min_blue
end
puts part2
