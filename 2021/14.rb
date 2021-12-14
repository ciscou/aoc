INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

TEMPLATE = INPUT.first

RULES = Hash[INPUT[2..-1].map { |l| l.split(" -> ") }]

def evolve(polymer)
  last_element = nil

  polymer = polymer.each_cons(2).map do |a, b|
    last_element = b

    [a, RULES["#{a}#{b}"]]
  end.flatten

  polymer << last_element
end

def substract(polymer)
  minmax = polymer.tally.minmax { |a, b| a.last <=> b.last }

  minmax.last.last - minmax.first.last
end

polymer = TEMPLATE.chars

stats = [polymer.tally]

15.times do |i|
  polymer = evolve(polymer)
  stats << polymer.tally
end

elements = stats.first.map(&:first)
puts "  " + elements.map { |e| e.ljust(8, " ") }.join(" | ")

stats.each do |stat|
  puts "  " + elements.map { |e| stat[e].to_s.rjust(8, " ") }.join(" | ")
end
