INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

RANGES_INPUT, PRODUCT_IDS_INPUT = INPUT.chunk { _1.empty? && nil }.map(&:last)

ranges = RANGES_INPUT.map { Range.new(*it.split("-").map(&:to_i)) }

product_ids = PRODUCT_IDS_INPUT.map(&:to_i)

part1 = product_ids.count do |product_id|
  ranges.any? { it.include?(product_id) }
end

puts part1

def merge_ranges(ranges)
  ranges = ranges.sort_by!(&:begin)
  res = [ranges.first]

  ranges.each do |range|
    if res.last.overlap?(range)
      last_range = res.pop

      if range.end > last_range.end
        range = Range.new(last_range.begin, range.end)
      else
        range = last_range
      end
    end

    res.push(range)
  end

  res
end

ranges = merge_ranges(ranges)

part2 = ranges.sum do |r|
  r.end - r.begin + 1
end

puts part2
