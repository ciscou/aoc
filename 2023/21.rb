INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = {}
srow, scol = nil, nil

INPUT.each_with_index do |line, row|
  line.chars.each_with_index do |char, col|
    if char == "S"
      srow = row
      scol = col
      char = "."
    end
    grid[[row, col]] = char
  end
end

# 11.times do |row|
#   11.times do |col|
#     print grid[[row, col]]
#   end
#   puts
# end

reachable_in_steps_cache = Hash.new { |h, k| h[k] = Set.new }
reachable_in_steps_cache[0].add([srow, scol])

def calculate_reachable_in_steps(grid, steps, reachable_in_steps_cache)
  return if steps == 0

  calculate_reachable_in_steps(grid, steps - 1, reachable_in_steps_cache)

  reachable_in_steps_cache[steps - 1].each do |pos|
    row, col = pos
    reachable_in_steps_cache[steps].add([row, col-1]) if grid[[row, col-1]] == "."
    reachable_in_steps_cache[steps].add([row, col+1]) if grid[[row, col+1]] == "."
    reachable_in_steps_cache[steps].add([row-1, col]) if grid[[row-1, col]] == "."
    reachable_in_steps_cache[steps].add([row+1, col]) if grid[[row+1, col]] == "."
  end
end

steps = 64

calculate_reachable_in_steps(grid, steps, reachable_in_steps_cache)

p reachable_in_steps_cache[steps].size
