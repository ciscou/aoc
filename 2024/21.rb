INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

# highly inspired by https://github.com/mattbillenstein/aoc/blob/main/2024/21/p.py and others

NUMERIC_KEYPAD = [
  ["7", "8", "9"],
  ["4", "5", "6"],
  ["1", "2", "3"],
  [nil, "0", "A"],
]

DIRECTIONAL_KEYPAD = [
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

NUMERIC_KEYPAD_KEY_POSITION = key_positions(NUMERIC_KEYPAD)

DIRECTIONAL_KEYPAD_KEY_POSITION = key_positions(DIRECTIONAL_KEYPAD)

def calculate_paths(keypad_key_at, keypad_key_positions)
  paths = Hash.new { |h, k| h[k] = {} }

  keypad_key_positions.each do |k1, p1|
    r1, c1 = p1

    keypad_key_positions.each do |k2, p2|
      r2, c2 = p2

      dr = r2 - r1
      dc = c2 - c1

      r = [dr < 0 ? -1 : 1, 0, dr < 0 ? "^" : "v"]
      c = [0, dc < 0 ? -1 : 1, dc < 0 ? "<" : ">"]

      first_r_then_c = ([r] * dr.abs) + ([c] * dc.abs)
      first_c_then_r = ([c] * dc.abs) + ([r] * dr.abs)

      paths[k1][k2] = [
        first_r_then_c,
        first_c_then_r,
      ].uniq.select do |path|
        r, c = r1, c1

        path.none? do |dr, dc, _key|
          r += dr
          c += dc

          keypad_key_at[r][c].nil?
        end
      end.map do |path|
        path.map { |_dr, _dc, key| key } + ["A"]
      end
    end
  end

  paths
end

NUMERIC_KEYPAD_PATHS = calculate_paths(NUMERIC_KEYPAD, NUMERIC_KEYPAD_KEY_POSITION)
DIRECTIONAL_KEYPAD_PATHS = calculate_paths(DIRECTIONAL_KEYPAD, DIRECTIONAL_KEYPAD_KEY_POSITION)

def helper(keys, depth, paths, cache)
  return keys.length if depth == 0

  return cache[[keys, depth]] if cache.key?([keys, depth])

  ans = 0
  prev_key = "A"

  keys.each do |key|
    ans += paths[prev_key][key].map do |path|
      helper(path, depth - 1, DIRECTIONAL_KEYPAD_PATHS, cache)
    end.min
    prev_key = key
  end

  cache[[keys, depth]] = ans
end

def part(codes, depth)
  ans = 0

  codes.each do |code|
    ans += code.to_i * helper(code.chars, depth, NUMERIC_KEYPAD_PATHS, {})
  end

  ans
end

part1 = part(INPUT, 3)
puts part1

part2 = part(INPUT, 26)
puts part2
