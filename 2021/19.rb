INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def all_24_rotations_bak(pos)
  x, y, z = pos

  [
    [ x,  y,  z],
    [ x,  y, -z],
    [ x, -y,  z],
    [ x, -y, -z],

    [ x,  z,  y],
    [ x,  z, -y],
    [ x, -z,  y],
    [ x, -z, -y],

    [  x, y,  z],
    [  x, y, -z],
    [ -x, y,  z],
    [ -x, y, -z],

    [  z, y,  x],
    [  z, y, -x],
    [ -z, y,  x],
    [ -z, y, -x],

    [  x,  y, z],
    [  x, -y, z],
    [ -x,  y, z],
    [ -x, -y, z],

    [  y,  x, z],
    [  y, -x, z],
    [ -y,  x, z],
    [ -y, -x, z]
  ]
end

def all_24_rotations(pos)
  x, y, z = pos

  [
    [x, y, z],
    [x, -z, y],
    [x, -y, -z],
    [x, z, -y],
    [x, y, z],
    [z, y, -x],
    [z, x, y],
    [z, -y, x],
    [z, -x, -y],
    [z, y, -x],
    [-x, y, -z],
    [-x, z, y],
    [-x, -y, z],
    [-x, -z, -y],
    [-x, y, -z],
    [-z, y, x],
    [-z, -x, y],
    [-z, -y, -x],
    [-z, x, -y],
    [-z, y, x],
    [x, y, z],
    [x, -z, y],
    [x, -y, -z],
    [x, z, -y],
  ]
end

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
  reports.each do |scanner_2, positions_2|
    next unless scanner_2 > scanner_1

    matches = nil

    positions_1.each do |pos1|
      positions_2.each do |pos2|
        # let's assume pos1 and pos2 are the same point from different scanners
        # let's count coincidences

        x1, y1, z1 = pos1
        24.times do |rotation|
          rotated_pos2 = all_24_rotations(pos2)[rotation]
          x2, y2, z2 = rotated_pos2
          ox, oy, oz = x2 - x1, y2 - y1, z2 - z1

          translated_positions_2 = positions_2.map { |x, y, z| all_24_rotations([x, y, z])[rotation] }.map { |x, y, z| [x - ox, y - oy, z - oz] }

          # if rotation == 11 && scanner_1 == 0 && scanner_2 == 1 && pos1 == [-618,-824,-621] && pos2 == [686,422,578]
          #   p [:pos1, pos1]
          #   p [:pos2, pos2]
          #   p [:rotated_pos2, rotated_pos2]
          #   p [:offsets, [ox, oy, oz]]
          #   p [:rotated_translated, [x2 - ox, y2 - oy, z2 - oz]]
          #   p [:positions_1, positions_1]
          #   p [:positions_2, translated_positions_2]
          #   p [:intersection, positions_1 & translated_positions_2]
          #   $stdin.gets
          # end

          matches = [ox, oy, oz] if (positions_1 & translated_positions_2).size >= 12
        end
      end
    end

    p [scanner_1, scanner_2, matches] if matches
  end
end
