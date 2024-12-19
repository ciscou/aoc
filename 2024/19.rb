INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

TOWELS = INPUT[0].split(", ")
PATTERNS = INPUT[2..]

def backtrack(pattern, offset, cache)
  return cache[offset] if cache.key?(offset)

  return true if offset == pattern.length

  TOWELS.each do |towel|
    next unless pattern[offset, towel.length] == towel

    if backtrack(pattern, offset + towel.length, cache)
      cache[offset] = true
      return true
    end
  end

  cache[offset] = false
  false
end

part1 = PATTERNS.count { backtrack(_1, 0, {}) }
puts part1
