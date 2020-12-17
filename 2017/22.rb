input = <<EOS
#..#...#.#.#..#.#...##.##
.....##.#....#.#......#.#
..#.###.#.#######.###.#.#
.......#.##.###.###..##.#
#....#...#.###....##.....
#.....##.#########..#.#.#
.####.##..#...###.##...#.
#....#..#.###.##.#..##.#.
#####.#.#..#.##..#...####
##.#.#..#.#....###.######
.##.#...#...##.#.##..####
...#..##.#.....#.#..####.
#.##.###..#######.#..#.#.
##....##....##.#..#.##..#
##.#.#.#.##...##.....#...
.#####..#.#....#.#######.
####....###.###.#.#..#..#
.###...#.###..#..#.#####.
#.###..#.#######.#.#####.
.##.#.###.##.##.#.#...#..
######.###.#.#.##.####..#
##..####.##..##.#...##...
...##.##...#..#..##.####.
#.....##.##.#..##.##....#
#.#..####.....#....#.###.
EOS

grid = Hash.new { |h, k| h[k] = {} }

input.lines.each_with_index do |line, row|
  line.chomp!

  line.chars.each_with_index do |c, col|
    grid[row][col] = c == "#" ? :infected : :clean
  end
end

row = grid.length / 2
col = grid[row].length / 2
dir = 0 # 0: up, 1: right, 2: down, 3: left

infections = 0

10_000_000.times do |i|
  # puts i if i % 1_000 == 0

  state = grid[row][col] || :clean

  case state
  when :clean
    dir -= 1
    grid[row][col] = :weakened
  when :weakened
    # do not turn
    grid[row][col] = :infected
    infections += 1
  when :infected
    dir += 1
    grid[row][col] = :flagged
  when :flagged
    dir += 2
    grid[row][col] = :clean
  else
    raise "invalid state #{state.inspect}"
  end

  dir %= 4

  case dir
  when 0 then row -= 1
  when 1 then col += 1
  when 2 then row += 1
  when 3 then col -= 1
  end
end

p infections
