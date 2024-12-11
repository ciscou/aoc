INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

stones = Hash.new(0)
INPUT.first.split(" ").map(&:to_i).each { stones[_1] += 1 }

75.times do
  next_stones = stones.dup
  stones.each do |k, v|
    next_stones[k] -= v
    if k == 0
      next_stones[1] += v
    else
      to_s = k.to_s
      p, q = to_s.length.divmod(2)
      if q == 0
        next_stones[to_s[0, p].to_i] += v
        next_stones[to_s[p, p].to_i] += v
      else
        next_stones[k * 2024] += v
      end
    end
  end
  stones = next_stones
  puts stones.values.sum if [24, 74].include?(_1)
end
