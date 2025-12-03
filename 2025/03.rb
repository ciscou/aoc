INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

part1 = 0
part2 = 0

INPUT.each do |line|
  seen = Hash.new { |h, k| h[k] = Set.new }
  seen[0].add([0, -1])

  line.chars.map(&:to_i).each_with_index do |digit, offset|
    (1..12).each do |length|
      seen[length - 1].each do |prefix, prefix_offset|
        next unless offset > prefix_offset
        seen[length].add([prefix * 10 + digit, offset])
      end
    end

    seen.each do |k, v|
      max_per_offset = Hash.new(0)
      v.each do |prefix, prefix_offset|
        max_per_offset[prefix_offset] = [max_per_offset[prefix_offset], prefix].max
      end
      v.clear
      max_per_offset.each do |prefix_offset, prefix|
        v.add([prefix, prefix_offset])
      end
    end
  end

  part1 += seen[2].map(&:first).max
  part2 += seen[12].map(&:first).max
end

puts part1
puts part2
