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

def find_o2(numbers, offset)
  if numbers.length == 1
    return numbers.first
  end

  counts = numbers.each_with_object({ "0" => [], "1" => [] }) do |e, a|
    e.chars.each_with_index do |b, i|
      a["0"][i] ||= 0
      a["1"][i] ||= 0
      a[b][i] += 1
    end
  end

  most_common = counts["0"][offset] > counts["1"][offset] ? "0" : "1"
  most_common = "1" if counts["0"][offset] == counts["1"][offset]

  find_o2(numbers.select { |n| n[offset] == most_common }, offset + 1)
end

def find_co2(numbers, offset)
  if numbers.length == 1
    return numbers.first
  end

  counts = numbers.each_with_object({ "0" => [], "1" => [] }) do |e, a|
    e.chars.each_with_index do |b, i|
      a["0"][i] ||= 0
      a["1"][i] ||= 0
      a[b][i] += 1
    end
  end

  least_common = counts["0"][offset] < counts["1"][offset] ? "0" : "1"
  least_common = "0" if counts["0"][offset] == counts["1"][offset]

  find_co2(numbers.select { |n| n[offset] == least_common }, offset + 1)
end

def part2
  [find_o2(INPUT, 0), find_co2(INPUT, 0)].map { |s| s.to_i(2) }
end

puts part1.inject(:*)
puts part2.inject(:*)
