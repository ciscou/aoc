INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

TOWELS = INPUT[0].split(", ")
PATTERNS = INPUT[2..]

def backtrack(pattern, offset, cache)
  return cache[offset] unless cache[offset].nil?

  return 1 if offset == pattern.length

  cache[offset] = TOWELS.sum do |towel|
    next 0 unless pattern[offset, towel.length] == towel

    backtrack(pattern, offset + towel.length, cache)
  end
end

part1 = 0
part2 = 0

PATTERNS.each do |pattern|
  n = backtrack(pattern, 0, [])

  part1 += 1 if n > 0
  part2 += n
end

puts part1
puts part2
