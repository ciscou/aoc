INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

galaxies = []

INPUT.each_with_index do |line, row|
  line.chars.each_with_index do |char, col|
    galaxies << [row, col] if char == "#"
  end
end

minrow, maxrow = galaxies.map(&:first).minmax
mincol, maxcol = galaxies.map(&:last).minmax
empty_rows = (minrow..maxrow).reject { galaxies.map(&:first).include?(_1) }
empty_cols = (mincol..maxcol).reject { galaxies.map(&:last).include?(_1) }

part1 = 0
galaxies.combination(2).each do |g1, g2|
  r1, c1 = g1
  r2, c2 = g2
  r1, r2 = [r1, r2].sort
  c1, c2 = [c1, c2].sort
  part1 += r2 - r1 + c2 - c1
  part1 += (r1..r2).count { empty_rows.include?(_1) }
  part1 += (c1..c2).count { empty_cols.include?(_1) }
end
puts part1

part2 = 0
galaxies.combination(2).each do |g1, g2|
  r1, c1 = g1
  r2, c2 = g2
  r1, r2 = [r1, r2].sort
  c1, c2 = [c1, c2].sort
  part2 += r2 - r1 + c2 - c1
  part2 += 999_999 * (r1..r2).count { empty_rows.include?(_1) }
  part2 += 999_999 * (c1..c2).count { empty_cols.include?(_1) }
end
puts part2
