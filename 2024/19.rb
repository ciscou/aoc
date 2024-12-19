INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

TOWELS = INPUT[0].split(", ")
PATTERNS = INPUT[2..]

def backtrack(pattern, offset, cache)
  return cache[offset] if cache.key?(offset)

  if offset == pattern.length
    cache[offset] = 1
    return 1
  end

  res = 0

  TOWELS.each do |towel|
    next unless pattern[offset, towel.length] == towel

    res += backtrack(pattern, offset + towel.length, cache)
  end

  cache[offset] = res
  res
end

part1 = PATTERNS.count { backtrack(_1, 0, {}) > 0 }
puts part1

part2 = PATTERNS.sum { backtrack(_1, 0, {}) }
puts part2
