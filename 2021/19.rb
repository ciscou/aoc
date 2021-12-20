INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

# def rx(pos)
#   x, y, z = pos
#   [x, -z, y]
# end

# def ry(pos)
#   x, y, z = pos
#   [z, y, -x]
# end

# def rz(pos)
#   x, y, z = pos
#   [-y, x, z]
# end

# def all_24_rotations_generator(pos)
#   rotations = []

#   4.times do |x|
#     4.times do |y|
#       4.times do |z|
#         x.times { pos = rx(pos) }
#         y.times { pos = ry(pos) }
#         z.times { pos = rz(pos) }

#         rotations << pos
#       end
#     end
#   end

#   4.times do |x|
#     4.times do |y|
#       4.times do |z|
#         x.times { pos = rx(pos) }
#         z.times { pos = rz(pos) }
#         y.times { pos = ry(pos) }

#         rotations << pos
#       end
#     end
#   end

#   4.times do |x|
#     4.times do |y|
#       4.times do |z|
#         y.times { pos = ry(pos) }
#         x.times { pos = rx(pos) }
#         z.times { pos = rz(pos) }

#         rotations << pos
#       end
#     end
#   end

#   4.times do |x|
#     4.times do |y|
#       4.times do |z|
#         y.times { pos = ry(pos) }
#         z.times { pos = rz(pos) }
#         x.times { pos = rx(pos) }

#         rotations << pos
#       end
#     end
#   end

#   4.times do |x|
#     4.times do |y|
#       4.times do |z|
#         z.times { pos = rz(pos) }
#         x.times { pos = rx(pos) }
#         y.times { pos = ry(pos) }

#         rotations << pos
#       end
#     end
#   end

#   4.times do |x|
#     4.times do |y|
#       4.times do |z|
#         z.times { pos = rz(pos) }
#         y.times { pos = ry(pos) }
#         x.times { pos = rx(pos) }

#         rotations << pos
#       end
#     end
#   end

#   rotations.sort.uniq
# end

# puts "before"
# puts all_24_rotations([1, 2, 3]).map(&:inspect)
# puts "after"
# exit(0)

def all_24_rotations(pos)
  x, y, z = pos

  [
    [-z, -y, -x],
    [-z, -x, y],
    [-z, x, -y],
    [-z, y, x],
    [-y, -z, x],
    [-y, -x, -z],
    [-y, x, z],
    [-y, z, -x],
    [-x, -z, -y],
    [-x, -y, z],
    [-x, y, -z],
    [-x, z, y],
    [x, -z, y],
    [x, -y, -z],
    [x, y, z],
    [x, z, -y],
    [y, -z, -x],
    [y, -x, z],
    [y, x, -z],
    [y, z, x],
    [z, -y, x],
    [z, -x, -y],
    [z, x, y],
    [z, y, -x]
  ]
end

# 24.times do |rotation1|
#   rotated123 = all_24_rotations([1, 2, 3])[rotation1]

#   puts "#{rotation1}, #{24.times.to_a.select { |rotation2| all_24_rotations(rotated123)[rotation2] == [1, 2, 3] }}"
# end
# exit(0)

# puts all_24_rotations([1, 2, 3]).map(&:inspect)
# exit(0)

# puts [1, 2, 3].inspect
# puts all_24_rotations([1, 2, 3])[18].inspect
# puts all_24_rotations(all_24_rotations([1, 2, 3])[18])[18].inspect
# exit(0)

def apply_transforms(transforms, pos)
  transforms.each do |rotation, ox, oy, oz|
    pos = all_24_rotations(pos)[rotation]
    x, y, z = pos
    pos = [x - ox, y - oy, z - oz]
  end

  pos
end

def inv_rotation(rotation)
  case rotation
  when  0 then  0
  when  1 then  7
  when  2 then 16
  when  3 then 23
  when  4 then 21
  when  5 then  5
  when  6 then 17
  when  7 then  1
  when  8 then  8
  when  9 then  9
  when 10 then 10
  when 11 then 11
  when 12 then 15
  when 13 then 13
  when 14 then 14
  when 15 then 12
  when 16 then  2
  when 17 then  6
  when 18 then 18
  when 19 then 22
  when 20 then 20
  when 21 then  4
  when 22 then 19
  when 23 then  3
  else raise "Invalid rotation #{rotation.inspect}"
  end
end

def inv_transform(transform)
  rotation, ox, oy, oz = transform
  ox, oy, oz = apply_transforms([[inv_rotation(rotation), 0, 0, 0]], [-ox, -oy, -oz])

  [inv_rotation(rotation), ox, oy, oz]
end

24.times do |rotation|
  p0 = [rand(100), rand(100), rand(100)]
  t1 = [rotation, rand(100), rand(100), rand(100)]
  p1 = apply_transforms([t1], p0)
  t2 = inv_transform(t1)
  p2 = apply_transforms([t2], p1)
  raise "uh oh..." unless p0 == p2
end

# puts "trying to get original of #{[498, -706, -2536].inspect}"
# p0 = [-538, -627, 2608]
# puts [:p0, p0].inspect
# t1 = [18, -1125, 168, -72]
# puts [:t1, t1].inspect
# p1 = apply_transforms([t1], p0)
# puts [:p1, p1].inspect
# inv_t1 = [t1[0]] + apply_transforms([[t1[0], 0, 0, 0]], [-t1[1], -t1[2], -t1[3]])
# puts [:t2, inv_t1].inspect
# p2 = apply_transforms([inv_t1], p1)
# puts [:p2, p2].inspect
# exit(0)

reports = Hash.new { |h, k| h[k] = [] }
scanner = nil

INPUT.each do |line|
  if line.empty?
    scanner = nil
    next
  end

  if scanner.nil?
    scanner = line.split(" ")[2].to_i
  else
    reports[scanner] << line.split(",").map(&:to_i)
  end
end

equivalences = Hash.new { |h, k| h[k] = {} }

reports.each do |scanner_1, positions_1|
  reports.each do |scanner_2, positions_2|
    next unless scanner_2 > scanner_1

    matches = nil

    24.times do |rotation|
      rotated_positions_2 = positions_2.map { |x, y, z| all_24_rotations([x, y, z])[rotation] }

      positions_1.each.with_index do |pos1, i|
        rotated_positions_2.each.with_index do |pos2, j|
          next unless j > i

          # let's assume pos1 and pos2 are the same point from different scanners
          # let's count coincidences

          x1, y1, z1 = pos1
          x2, y2, z2 = pos2
          ox, oy, oz = x2 - x1, y2 - y1, z2 - z1

          rotated_translated_positions_2 = rotated_positions_2.map { |x, y, z| [x - ox, y - oy, z - oz] }

          count = (positions_1 & rotated_translated_positions_2).size
          matches = [rotation, ox, oy, oz] if count >= 12
        end
      end
    end

    equivalences[scanner_1][scanner_2] = matches if matches
  end
end

# equivalences.each do |s1, v|
#   v.each do |s2, matches|
#     puts "#{s1} is #{s2} with #{matches.inspect}"
#   end
# end
# exit(0)

normalized_reports = []

if ARGV.first == "19_example.txt"
  reports[0].each do |pos|
    normalized_reports << apply_transforms([], pos)
  end

  reports[1].each do |pos|
    normalized_reports << apply_transforms([equivalences[0][1]], pos)
  end

  reports[3].each do |pos|
    normalized_reports << apply_transforms([equivalences[1][3], equivalences[0][1]], pos)
  end

  reports[4].each do |pos|
    normalized_reports << apply_transforms([equivalences[1][4], equivalences[0][1]], pos)
  end

  reports[2].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[2][4]), equivalences[1][4], equivalences[0][1]], pos)
  end
else
  reports[0].each do |pos|
    normalized_reports << apply_transforms([], pos)
  end

  reports[1].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[2].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[3].each do |pos|
    normalized_reports << apply_transforms([equivalences[2][3], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[4].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[4][5]), equivalences[0][5]], pos)
  end

  reports[5].each do |pos|
    normalized_reports << apply_transforms([equivalences[0][5]], pos)
  end

  reports[6].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[7].each do |pos|
    normalized_reports << apply_transforms([equivalences[4][7], inv_transform(equivalences[4][5]), equivalences[0][5]], pos)
  end

  reports[8].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[8][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[9].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[9][17]), equivalences[11][17], equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[10].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[10][17]), equivalences[11][17], equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[11].each do |pos|
    normalized_reports << apply_transforms([equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[12].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[12][20]), inv_transform(equivalences[20][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[13].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[13][30]), equivalences[1][30], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[14].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[14][17]), equivalences[11][17], equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[15].each do |pos|
    normalized_reports << apply_transforms([equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[16].each do |pos|
    normalized_reports << apply_transforms([equivalences[8][16], inv_transform(equivalences[8][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[17].each do |pos|
    normalized_reports << apply_transforms([equivalences[11][17], equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[18].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[18][21]), inv_transform(equivalences[21][29]), equivalences[6][29], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[19].each do |pos|
    normalized_reports << apply_transforms([equivalences[6][19], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[20].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[20][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[21].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[21][29]), equivalences[6][29], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[22].each do |pos|
    normalized_reports << apply_transforms([inv_transform(equivalences[22][25]), equivalences[12][25], inv_transform(equivalences[12][20]), inv_transform(equivalences[20][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[23].each do |pos|
    normalized_reports << apply_transforms([equivalences[1][23], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[24].each do |pos|
    normalized_reports << apply_transforms([equivalences[2][24], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[25].each do |pos|
    normalized_reports << apply_transforms([equivalences[12][25], inv_transform(equivalences[12][20]), inv_transform(equivalences[20][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[26].each do |pos|
    normalized_reports << apply_transforms([equivalences[0][26]], pos)
  end

  reports[27].each do |pos|
    normalized_reports << apply_transforms([equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[28].each do |pos|
    normalized_reports << apply_transforms([equivalences[3][28], equivalences[2][3], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[29].each do |pos|
    normalized_reports << apply_transforms([equivalences[6][29], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end

  reports[30].each do |pos|
    normalized_reports << apply_transforms([equivalences[1][30], inv_transform(equivalences[1][5]), equivalences[0][5]], pos)
  end
end

puts normalized_reports.sort.uniq.length

normalized_scanners_positions = []

if ARGV.first == "19_example.txt"
  normalized_scanners_positions << apply_transforms([], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[0][1]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[1][3], equivalences[0][1]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[1][4], equivalences[0][1]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[2][4]), equivalences[1][4], equivalences[0][1]], [0, 0, 0])
else
  normalized_scanners_positions << apply_transforms([], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[2][3], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[4][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[4][7], inv_transform(equivalences[4][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[8][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[9][17]), equivalences[11][17], equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[10][17]), equivalences[11][17], equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[12][20]), inv_transform(equivalences[20][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[13][30]), equivalences[1][30], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[14][17]), equivalences[11][17], equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[8][16], inv_transform(equivalences[8][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[11][17], equivalences[2][11], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[18][21]), inv_transform(equivalences[21][29]), equivalences[6][29], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[6][19], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[20][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[21][29]), equivalences[6][29], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([inv_transform(equivalences[22][25]), equivalences[12][25], inv_transform(equivalences[12][20]), inv_transform(equivalences[20][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[1][23], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[2][24], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[12][25], inv_transform(equivalences[12][20]), inv_transform(equivalences[20][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[0][26]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[3][28], equivalences[2][3], inv_transform(equivalences[2][15]), equivalences[6][15], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[6][29], inv_transform(equivalences[6][27]), equivalences[1][27], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
  normalized_scanners_positions << apply_transforms([equivalences[1][30], inv_transform(equivalences[1][5]), equivalences[0][5]], [0, 0, 0])
end

largest = normalized_scanners_positions.combination(2).map do |s1, s2|
  x1, y1, z1 = s1
  x2, y2, z2 = s2

  (x2 - x1).abs + (y2 - y1).abs + (z2 - z1).abs
end.max

puts largest

# puts "trying to get original of #{[498, -706, -2536].inspect}"
# p0 = [-538, -627, 2608]
# puts [:p0, p0].inspect
# t1 = [18, -1125, 168, -72]
# puts [:t1, t1].inspect
# p1 = apply_transforms([t1], p0)
# puts [:p1, p1].inspect
# inv_t1 = [t1[0]] + apply_transforms([[t1[0], 0, 0, 0]], [-t1[1], -t1[2], -t1[3]])
# puts [:t2, inv_t1].inspect
# p2 = apply_transforms([inv_t1], p1)
# puts [:p2, p2].inspect
# exit(0)