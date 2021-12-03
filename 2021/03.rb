INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def count_bits(numbers)
  length = numbers.first.length

  numbers.each_with_object({ "0" => Array.new(length, 0), "1" => Array.new(length, 0) }) do |e, a|
    e.chars.each_with_index do |b, i|
      a[b][i] += 1
    end
  end
end

def part1
  counts = count_bits(INPUT)

  γ = counts["0"].zip(counts["1"]).map { |c0, c1| c0 > c1 ? "0" : "1" }.join
  ε = counts["0"].zip(counts["1"]).map { |c0, c1| c0 < c1 ? "0" : "1" }.join

  [γ, ε].map { |s| s.to_i(2) }
end

def find_by_criteria(numbers, offset, &criteria)
  return numbers.first if numbers.length == 1

  counts = count_bits(numbers)
  keep = criteria.call(counts["0"][offset], counts["1"][offset])

  find_by_criteria(numbers.select { |n| n[offset] == keep }, offset + 1, &criteria)
end

def find_o2(numbers, offset)
  find_by_criteria(numbers, offset) do |c0, c1|
    c0 > c1 ? "0" : "1"
  end
end

def find_co2(numbers, offset)
  find_by_criteria(numbers, offset) do |c0, c1|
    c0 <= c1 ? "0" : "1"
  end
end

def part2
  [find_o2(INPUT, 0), find_co2(INPUT, 0)].map { |s| s.to_i(2) }
end

puts part1.inject(:*)
puts part2.inject(:*)
