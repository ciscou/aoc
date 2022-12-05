INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def reset_stacks
  empty_idx = INPUT.index(&:empty?)

  stacks = Array.new((INPUT[empty_idx-2].length + 1) / 4) { [] }

  INPUT[..empty_idx-2].reverse_each do |line|
    stacks.each_with_index do |stack, i|
      crate = line[i * 4 + 1]

      stack.push(crate) unless crate == " "
    end
  end

  stacks
end

def for_each_instruction
  empty_idx = INPUT.index(&:empty?)

  INPUT[empty_idx+1..].each do |line|
    words = line.split

    count, from, to = [1, 3, 5].map { |i| words[i].to_i }

    yield(count, from, to)
  end
end

stacks = reset_stacks
for_each_instruction do |count, from, to|
  count.times do
    crate = stacks[from-1].pop
    stacks[to-1].push crate
  end
end
puts stacks.map(&:last).join("")

stacks = reset_stacks
for_each_instruction do |count, from, to|
  crates = stacks[from-1].slice!(-count..)
  stacks[to-1].concat(crates)
end
puts stacks.map(&:last).join("")
