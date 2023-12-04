INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

cards = INPUT.map do |line|
  winning, have = line.split(": ").last.split(" | ").map { _1.split.map(&:to_i) }
  matches = winning & have
  { matches: matches.length, amount: 1 }
end

part1 = cards.sum do |card|
  matches = card[:matches]
  matches > 0 ? 2 ** (matches - 1) : 0
end

puts part1

cards.each_with_index do |card, i|
  card[:matches].times do |j|
    cards[i + j + 1][:amount] += card[:amount]
  end
end

part2 = cards.sum do |card|
  card[:amount]
end

puts part2
