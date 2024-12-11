INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

stones = INPUT.first.split(" ").map { [_1.to_i] }

25.times do
  stones.map! do |stone_group|
    stone_group.map do |stone|
      if stone == 0
        [1]
      else
        to_s = stone.to_s
        p, q = to_s.length.divmod(2)
        if q == 0
          [to_s[0, p].to_i, to_s[p, p].to_i]
        else
          [stone * 2024]
        end
      end
    end.flatten(1)
  end
end

part1 = stones.sum(&:length)
puts part1
