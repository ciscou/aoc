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

def inv_transform(transform)
  rotation, ox, oy, oz = transform
  ox, oy, oz = apply_transform([rotation, 0, 0, 0], [-ox, -oy, -oz])

  [inv_rotation(rotation), -ox, -oy, -oz]
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

equivalences.each do |s1, v|
  v.each do |s2, matches|
    # puts "#{s1} is #{s2} with #{matches.inspect}"
  end
end

reports[0].each do |pos|
  puts apply_transforms([], pos).inspect
end

reports[1].each do |pos|
  puts apply_transforms([equivalences[0][1]], pos).inspect
end

reports[3].each do |pos|
  puts apply_transforms([equivalences[1][3], equivalences[0][1]], pos).inspect
end

reports[4].each do |pos|
  puts apply_transforms([equivalences[1][4], equivalences[0][1]], pos).inspect
end

reports[2].each do |pos|
  equivalences_2_4 = equivalences[2][4]
  inv_equivalences_2_4 = [equivalences_2_4[0]] + apply_transforms([[equivalences_2_4[0], 0, 0, 0]], [-equivalences_2_4[1], -equivalences_2_4[2], -equivalences_2_4[3]])
  # puts "aki"
  # puts [:t1, equivalences_2_4].inspect
  # puts [:p0, pos].inspect
  pos = apply_transforms([inv_equivalences_2_4, equivalences[1][4], equivalences[0][1]], pos)
  # pos = apply_transforms([inv_equivalences_2_4], pos)
  # puts [:t2, inv_equivalences_2_4].inspect
  # puts [:p1, pos].inspect
  # $stdin.gets
  puts pos.inspect
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
