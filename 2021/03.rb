INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def part1
  counts = INPUT.each_with_object({ "0" => Hash.new(0), "1" => Hash.new(0) }) do |e, a|
    e.chars.each_with_index do |b, i|
      a[b][i] += 1
    end
  end

  counts_0 = counts["0"].to_a.sort.map(&:last)
  counts_1 = counts["1"].to_a.sort.map(&:last)

  γ = counts_0.zip(counts_1).map { |c0, c1| c0 > c1 ? "0" : "1" }.join
  ε = counts_0.zip(counts_1).map { |c0, c1| c0 < c1 ? "0" : "1" }.join

  [γ, ε].map { |s| s.to_i(2) }
end

puts part1.inject(:*)
