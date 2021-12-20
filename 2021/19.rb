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

# puts all_24_rotations([1, 2, 3]).map(&:inspect)
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

reports.each do |scanner_1, positions_1|
  # puts scanner_1
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

    puts [scanner_1, scanner_2, matches].inspect if matches
  end
end
