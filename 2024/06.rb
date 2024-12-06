INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

map = INPUT.map(&:chars)

guard_row = nil
guard_col = nil
guard_dir = nil

map.length.times do |row|
  map[row].length.times do |col|
    if map[row][col] == "^"
      map[row][col] = "."
      guard_row = row
      guard_col = col
      guard_dir = :up
    end
  end
end

DROW_DCOL = {
  up: [-1, 0],
  right: [0, 1],
  down: [1, 0],
  left: [0, -1],
}

TURN_RIGHT = {
  up: :right,
  right: :down,
  down: :left,
  left: :up,
}

visited = Set.new
visited.add([guard_row, guard_col])

loop do
  drow, dcol = DROW_DCOL[guard_dir]

  guard_row += drow
  guard_col += dcol

  break if guard_row < 0
  break if guard_col < 0
  break unless guard_row < map.length
  break unless guard_col < map[guard_row].length

  if map[guard_row][guard_col] == "#"
    guard_row -= drow
    guard_col -= dcol
    guard_dir = TURN_RIGHT[guard_dir]
  else
    visited.add([guard_row, guard_col])
  end
end

puts visited.size

part2 = 0

map.length.times do |obstacle_row|
  map[obstacle_row].length.times do |obstacle_col|
    map = INPUT.map(&:chars)

    guard_row = nil
    guard_col = nil
    guard_dir = nil

    map.length.times do |row|
      map[row].length.times do |col|
        if map[row][col] == "^"
          map[row][col] = "."
          guard_row = row
          guard_col = col
          guard_dir = :up
        end
      end
    end

    next if map[obstacle_row][obstacle_col] == "#"
    next if guard_row == obstacle_row && guard_col == obstacle_col

    map[obstacle_row][obstacle_col] = "#"

    visited = Set.new
    visited.add([guard_row, guard_col, guard_dir])

    loop do
      drow, dcol = DROW_DCOL[guard_dir]

      guard_row += drow
      guard_col += dcol

      break if guard_row < 0
      break if guard_col < 0
      break unless guard_row < map.length
      break unless guard_col < map[guard_row].length

      if map[guard_row][guard_col] == "#"
        guard_row -= drow
        guard_col -= dcol
        guard_dir = TURN_RIGHT[guard_dir]
      else
        unless visited.add?([guard_row, guard_col, guard_dir])
          part2 += 1
          break
        end
      end
    end
  end
end

puts part2
