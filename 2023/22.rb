INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def overlaps?(cube1, cube2)
  c11, c12 = cube1
  c21, c22 = cube2

  x11, y11, z11 = c11
  x12, y12, z12 = c12
  x21, y21, z21 = c21
  x22, y22, z22 = c22

  return false if x12 < x21
  return false if y12 < y21
  return false if z12 < z21

  return false if x11 > x22
  return false if y11 > y22
  return false if z11 > z22

  true
end

def chain_reaction(supported_by, i)
  supported_by = Hash[supported_by.map { [_1, _2.dup] }]
  delete = Set.new
  delete.add(i)
  loop do
    changed = false
    supported_by.values.each do |v|
      delete.each do |j|
        changed ||= v.delete(j)
      end
    end
    supported_by.each do |k, v|
      delete.add k if v.empty?
    end
    break unless changed
  end
  supported_by.values.count(&:empty?)
end

cubes = INPUT.map do |line|
  c1, c2 = line.split("~")
  [c1, c2].map { _1.split(",").map(&:to_i) }
end

cubes.sort_by! { _1[1][2] }

cubes.each do |cube|
  other_cubes = cubes - [cube]
  loop do
    cube[0][2] -= 1
    cube[1][2] -= 1
    overlapping = other_cubes.any? do |other_cube|
      overlaps?(cube, other_cube)
    end
    if cube[0][2] < 1 || cube[1][2] < 0 || overlapping
      cube[0][2] += 1
      cube[1][2] += 1
      break
    end
  end
end

supported_by = Hash.new { |h, k| h[k] = [] }

cubes.each_with_index do |cube, i|
  cube[0][2] -= 1
  cube[1][2] -= 1

  cubes.each_with_index do |other_cube, j|
    next if i == j

    supported_by[i] << j if overlaps?(cube, other_cube)
  end

  cube[0][2] += 1
  cube[1][2] += 1
end

# part1 = 0
# cubes.each_with_index do |cube, i|
  # part1 += 1 if supported_by.values.all? do |supported|
    # supported.length > 1 || !supported.include?(i)
  # end
# end
# puts part1

part2 = 0
cubes.each_with_index do |cube, i|
  puts i
  part2 += chain_reaction(supported_by, i)
end
puts part2
