INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

BLIZZARDS = []
WIDTH = INPUT.first.length - 2
HEIGHT = INPUT.length - 2
CYCLE = WIDTH.lcm(HEIGHT)

INPUT.each_with_index do |line, row|
  line.chars.each_with_index do |char, col|
    next if ["#", "."].include? char

    BLIZZARDS << {
      char: char,
      pos: [row - 1, col - 1],
      dir: {
        "^" => [-1,  0],
        "v" => [ 1,  0],
        "<" => [ 0, -1],
        ">" => [ 0,  1],
      }.fetch(char),
    }
  end
end

BLIZZARDS_BY_POS_CACHE = {}
def calculate_blizzards_by_pos(min)
  return BLIZZARDS_BY_POS_CACHE[min % CYCLE] if BLIZZARDS_BY_POS_CACHE.key?(min % CYCLE)

  blizzards_by_pos = Hash.new { |h, k| h[k] = [] }

  BLIZZARDS.each do |blizzard|
    pos = [
      (blizzard[:pos][0] + blizzard[:dir][0] * min) % HEIGHT,
      (blizzard[:pos][1] + blizzard[:dir][1] * min) % WIDTH,
    ]

    blizzards_by_pos[pos] << blizzard
  end

  BLIZZARDS_BY_POS_CACHE[min % CYCLE] = blizzards_by_pos
end

def run(from, to, min)
  queue = []
  queue << { pos: from, min: min }

  visited = {}

  until queue.empty?
    node = queue.shift

    pos, min = node.values_at(:pos, :min)
    row, col = pos

    return min if [row, col] == to

    next if visited[[row, col, min % CYCLE]]
    visited[[row, col, min % CYCLE]] = true

    blizzards_by_pos = calculate_blizzards_by_pos(min)

    next if blizzards_by_pos[pos].length > 0

    [
      [-1,  0],
      [ 1,  0],
      [ 0, -1],
      [ 0,  1],
      [ 0,  0],
    ].each do |drow, dcol|
      next_row = row + drow
      next_col = col + dcol
      next_min = min + 1

      next if next_row < 0 && next_col != 0
      next if next_col < 0
      next if next_row >= HEIGHT && next_col != WIDTH - 1
      next if next_col >= WIDTH

      queue << { pos: [next_row, next_col], min: next_min }
    end
  end

  -1
end

part1 = run([-1, 0], [HEIGHT, WIDTH - 1], 0)
puts part1

part2 = part1
part2 = run([HEIGHT, WIDTH - 1], [-1, 0], part2)
part2 = run([-1, 0], [HEIGHT, WIDTH - 1], part2)
puts part2
