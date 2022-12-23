require "set"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

elves = []

INPUT.each_with_index do |line, r|
  line.chars.each_with_index do |char, c|
    elves << { pos: [r, c] } if char == "#"
  end
end

decisions = [
  [[-1, -1], [-1,  0], [-1,  1]],
  [[ 1, -1], [ 1,  0], [ 1,  1]],
  [[-1, -1], [ 0, -1], [ 1, -1]],
  [[-1,  1], [ 0,  1], [ 1,  1]],
]

rounds = 0

loop do
  rounds += 1

  curr_pos = Set.new(elves.map { _1[:pos] })
  next_pos = Hash.new(0)

  elves.each do |elf|
    r, c = elf[:pos]

    next if [
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

    4.times do |i|
      decision = decisions[(rounds - 1 + i) % 4]
      d1, d2, d3 = decision.map { [r + _1, c + _2] }

      elf[:next_pos] ||= d2 if [d1, d2, d3].none? { curr_pos.include?(_1) }
    end

    next_pos[elf[:next_pos]] += 1 if elf[:next_pos]
  end

  no_elf_moved = true
  elves.each do |elf|
    if elf[:next_pos] && next_pos[elf[:next_pos]] == 1
      no_elf_moved = false
      elf[:pos] = elf[:next_pos]
    end

    elf.delete(:next_pos)
  end

  if rounds == 10
    minx, maxx = elves.map { _1[:pos][0] }.minmax
    miny, maxy = elves.map { _1[:pos][1] }.minmax

    puts (maxx - minx + 1) * (maxy - miny + 1) - elves.size
  end

  break if no_elf_moved
end

puts rounds
