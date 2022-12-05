INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

empty_idx = INPUT.index(&:empty?)

stacks = Array.new((INPUT[empty_idx-2].length + 1) / 4) { [] }

INPUT[..empty_idx-2].reverse_each do |line|
  stacks.each_with_index do |stack, i|
    crate = line[i * 4 + 1]

    stack.push(crate) unless crate == " "
  end
end

INPUT[empty_idx+1..].each do |line|
  words = line.split

  count, from, to = [1, 3, 5].map { |i| words[i].to_i }

  count.times do
    crate = stacks[from-1].pop
    stacks[to-1].push crate
  end
end

puts stacks.map(&:last).join("")
