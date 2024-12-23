INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

# highly inspired by https://github.com/mattbillenstein/aoc/blob/main/2024/21/p.py and others
#
numeric_keypad = [
  ["7", "8", "9"],
  ["4", "5", "6"],
  ["1", "2", "3"],
  [nil, "0", "A"],
]

directional_keypad = [
  [nil, "^", "A"],
  ["<", "v", ">"],
]

def key_positions(keypad)
  positions = {}
  keypad.each_with_index do |row, r|
    row.each_with_index do |cell, c|
      positions[cell] = [r, c]
    end
  end
  positions
end

numeric_keypad_key_position = key_positions(numeric_keypad)

directional_keypad_key_position = key_positions(directional_keypad)

def calculate_paths(keypad_key_at, keypad_key_positions)
  paths = Hash.new { |h, k| h[k] = {} }

  keypad_key_positions.each do |k1, p1|
    next if k1.nil?

    keypad_key_positions.each do |k2, p2|
      next if k2.nil?

      r1, c1 = p1
      r2, c2 = p2

      dr = r2 - r1
      dc = c2 - c1

      r = dr < 0 ? "^" : "v"
      c = dc < 0 ? "<" : ">"

      first_r_then_c = ([r] * dr.abs) + ([c] * dc.abs) + ["A"]
      first_c_then_r = ([c] * dc.abs) + ([r] * dr.abs) + ["A"]

      paths[k1][k2] = [
        first_r_then_c,
        first_c_then_r,
      ].uniq.select do |path|
        r, c = r1, c1
        valid = true

        path.each do |dir|
          next if dir == "A"

          dr, dc = {
            "^" => [-1,  0],
            "v" => [ 1,  0],
            "<" => [ 0, -1],
            ">" => [ 0,  1],
          }.fetch(dir)
          r += dr
          c += dc

          valid = false if keypad_key_at[r][c].nil?
        end

        valid
      end
    end
  end

  paths
end

numeric_keypad_paths = calculate_paths(numeric_keypad, numeric_keypad_key_position)
directional_keypad_paths = calculate_paths(directional_keypad, directional_keypad_key_position)

def helper(keys, depth, paths, directional_keypad_paths, cache)
  return keys.length if depth == 0

  return cache[[keys, depth]] if cache.key?([keys, depth])

  ans = 0
  prev_key = "A"

  keys.each do |key|
    ans += paths[prev_key][key].map do |path|
      helper(path, depth - 1, directional_keypad_paths, directional_keypad_paths, cache)
    end.min
    prev_key = key
  end

  cache[[keys, depth]] = ans
end

def part(codes, depth, numeric_keypad_paths, directional_keypad_paths)
  ans = 0

  codes.each do |code|
    ans += code.to_i * helper(code.chars, depth, numeric_keypad_paths, directional_keypad_paths, {})
  end

  ans
end

part1 = part(INPUT, 3, numeric_keypad_paths, directional_keypad_paths)
puts part1

part2 = part(INPUT, 26, numeric_keypad_paths, directional_keypad_paths)
puts part2
