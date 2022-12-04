INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Range
  # File activesupport/lib/active_support/core_ext/range/overlaps.rb, line 7
  def overlaps?(other)
    cover?(other.first) || other.cover?(first)
  end
end

assignements = INPUT.map do |line|
  line.split(",").map do |r|
    l, h = r.split("-").map(&:to_i)
    l..h
  end
end

part1 = assignements.count do |range1, range2|
  range1.cover?(range2) || range2.cover?(range1)
end
puts part1

part2 = assignements.count do |range1, range2|
  range1.overlaps?(range2)
end
puts part2
