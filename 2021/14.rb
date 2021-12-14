INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

TEMPLATE = INPUT.first

RULES = Hash[INPUT[2..-1].map { |l| l.split(" -> ") }]

def evolve(polymer, times)
  times.times do |i|
    puts i

    last_element = nil

    polymer = polymer.each_cons(2).map do |a, b|
      last_element = b

      [a, RULES["#{a}#{b}"]]
    end.flatten

    polymer << last_element
  end

  polymer
end

def substract(polymer)
  counts = polymer.group_by(&:itself).map { |k, v| [k, v.length] }
  minmax = counts.minmax { |a, b| a.last <=> b.last }

  minmax.last.last - minmax.first.last
end

polymer = TEMPLATE.chars

polymer = evolve(polymer, 10)
puts substract(polymer)

polymer = evolve(polymer, 30)
puts substract(polymer)
