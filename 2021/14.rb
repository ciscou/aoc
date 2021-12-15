INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

TEMPLATE = INPUT.first

RULES = Hash[INPUT[2..-1].map { |l| l.split(" -> ") }]

def evolve_polymer(polymer)
  last_element = nil

  polymer = polymer.each_cons(2).map do |a, b|
    last_element = b

    [a, RULES["#{a}#{b}"]]
  end.flatten

  polymer << last_element
end

def substract(elements_counts)
  minmax = elements_counts.minmax { |a, b| a.last <=> b.last }

  minmax.last.last - minmax.first.last
end

def evolve_polymer_pairs_and_elements_counts(polymer_pairs, elements_counts)
  next_polymer_pairs = Hash.new(0)
  next_elements_counts = elements_counts.dup

  polymer_pairs.each do |k, v|
    a, c = k.chars
    b = RULES[k]

    next_polymer_pairs["#{a}#{b}"] += v
    next_polymer_pairs["#{b}#{c}"] += v

    next_elements_counts[b] += v
  end

  [next_polymer_pairs, next_elements_counts]
end

def part1
  polymer = TEMPLATE.chars

  10.times do |i|
    polymer = evolve_polymer(polymer)
  end

  substract(polymer.tally)
end

def part2
  polymer = TEMPLATE.chars

  polymer_pairs = Hash.new(0)

  polymer.each_cons(2).each do |a, b|
    polymer_pairs["#{a}#{b}"] += 1
  end

  elements_counts = Hash.new(0)

  polymer.each do |e|
    elements_counts[e] += 1
  end

  40.times do |i|
    polymer_pairs, elements_counts = evolve_polymer_pairs_and_elements_counts(polymer_pairs, elements_counts)
  end

  substract(elements_counts)
end

puts part1
puts part2
