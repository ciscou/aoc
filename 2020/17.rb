input = <<EOS
..#..#.#
##.#..#.
#....#..
.#..####
.....#..
...##...
.#.##..#
.#.#.#.#
EOS

cube = {}

input.lines.each_with_index do |line, y|
  line.chomp!

  line.chars.each_with_index do |char, x|
    cube[[x, y, 0, 0]] = char == "#"
  end
end

def neightbors(c)
  x, y, z, w = c

  res = []

  [-1, 0, 1].each do |dx|
    [-1, 0, 1].each do |dy|
      [-1, 0, 1].each do |dz|
        [-1, 0, 1].each do |dw|
          res << [x + dx, y + dy, z + dz, w + dw]
        end
      end
    end
  end

  res.delete([x, y, z, w])

  res
end

def evolve(cube)
  candidates = cube.keys + cube.keys.flat_map { |c| neightbors(c) }
  candidates.sort!.uniq!

  new_cube = {}

  candidates.each do |c|
    active_neightbors = neightbors(c).count { |nc| cube[nc] }
    new_cube[c] = if cube[c]
                    active_neightbors == 2 || active_neightbors == 3
                  else
                    active_neightbors == 3
                  end
  end

  new_cube
end

6.times do |i|
  cube = evolve(cube)
end

p cube.values.count(&:itself)
