INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

ranges = INPUT.first.split(",").map do |range|
  a, b = range.split("-").map(&:to_i)
  Range.new(a, b)
end

part1 = []
part2 = []

ranges.each do |range|
  range.each do |n|
    s = n.to_s

    (1..(s.length / 2)).each do |l|
      next unless s.length % l == 0

      chunks = s.chars.each_slice(l).map(&:join)

      if chunks.uniq.size == 1
        part1 << n if chunks.size == 2
        part2 << n
      end
    end
  end
end

puts part1.uniq.sum
puts part2.uniq.sum
