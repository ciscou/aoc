INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

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

def apply_transforms(transforms, pos)
  transforms.each do |rotation, ox, oy, oz|
    pos = all_24_rotations(pos)[rotation]
    x, y, z = pos
    pos = [x - ox, y - oy, z - oz]
  end

  pos
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

transforms = Hash.new { |h, k| h[k] = {} }

reports.each do |scanner_1, positions_1|
  reports.each do |scanner_2, positions_2|
    next unless scanner_2 > scanner_1

    transform = nil

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
          transform = [rotation, ox, oy, oz] if count >= 12
        end
      end
    end

    if transform
      transforms[scanner_1][scanner_2] = transform
      transforms[scanner_2][scanner_1] = inv_transform(transform)
    end
  end
end

def transforms_from_to(transforms, from, to)
  queue = [[from, []]]
  visited = { from => true }

  until queue.empty?
    s1, ts = queue.shift
    return ts if s1 == to

    transforms[s1].each do |s2, t|
      next if visited[s2]
      visited[s2] = true

      queue.push([s2, [t] + ts])
    end
  end

  raise "transform from #{from.inspect} to #{to.inspect} not found"
end

transforms_from_0 = {}
reports.keys.each { |s| transforms_from_0[s] = transforms_from_to(transforms, 0, s) }

normalized_reports = []

reports.each do |scanner, positions|
  positions.each do |pos|
    normalized_reports << apply_transforms(transforms_from_0[scanner], pos)
  end
end

puts normalized_reports.sort.uniq.length

normalized_scanners_positions = []

reports.keys.each do |scanner|
  normalized_scanners_positions << apply_transforms(transforms_from_0[scanner], [0, 0, 0])
end

largest = normalized_scanners_positions.combination(2).map do |s1, s2|
  x1, y1, z1 = s1
  x2, y2, z2 = s2

  (x2 - x1).abs + (y2 - y1).abs + (z2 - z1).abs
end.max

puts largest
