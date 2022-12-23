require "set"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

elves = []

INPUT.each_with_index do |line, r|
  line.chars.each_with_index do |char, c|
    if char == "#"
      elves << { pos: [r, c] }
    end
  end
end

decisions = [
  [[-1, -1], [-1,  0], [-1,  1]],
  [[ 1, -1], [ 1,  0], [ 1,  1]],
  [[-1, -1], [ 0, -1], [ 1, -1]],
  [[-1,  1], [ 0,  1], [ 1,  1]],
]

11.times do
  curr_pos = Set.new(elves.map { _1[:pos] })
  next_pos = Hash.new(0)

  minx, maxx = elves.map { _1[:pos][0] }.minmax
  miny, maxy = elves.map { _1[:pos][1] }.minmax
  puts (maxx - minx + 1) * (maxy - miny + 1) - elves.size
  # minx -= 1
  # maxx += 1
  # miny -= 1
  # maxx += 1
  # (minx..maxx).each do |y|
  #   (miny..maxy).each do |x|
  #     print curr_pos.include?([y, x]) ? "#" : "."
  #   end
  #   puts
  # end
  # puts
  # gets

  elves.each do |elf|
    r, c = elf[:pos]

    if [
      [r-1, c-1],
      [r-1, c  ],
      [r-1, c+1],
      [r  , c-1],
      # [r  , c  ],
      [r  , c+1],
      [r+1, c-1],
      [r+1, c  ],
      [r+1, c+1],
    ].none? { curr_pos.include?(_1) }
      # puts "#{elf.inspect} choose not to move"
      next
    end

    decisions.each do |decision|
      d1, d2, d3 = decision.map { [r + _1, c + _2] }

      elf[:next_pos] ||= d2 if [d1, d2, d3].none? { curr_pos.include?(_1) }
    end

    next_pos[elf[:next_pos]] += 1 if elf[:next_pos]
  end

  elves.each do |elf|
    if elf[:next_pos] && next_pos[elf[:next_pos]] == 1
      elf[:pos] = elf[:next_pos]
    end

    elf.delete(:next_pos)
  end

  decisions.push(decisions.shift)
end

minx, maxx = elves.map { _1[:pos][0] }.minmax
miny, maxy = elves.map { _1[:pos][1] }.minmax
