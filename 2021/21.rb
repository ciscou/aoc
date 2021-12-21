INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class DeterministicDie
  def initialize
    @next = 1
    @rolls = 0
  end

  attr_reader :rolls

  def roll
    res = @next
    @next += 1
    @next = 1 if @next > 100

    @rolls += 1

    res
  end
end

p1 = INPUT[0].split(": ").last.to_i - 1
p2 = INPUT[1].split(": ").last.to_i - 1

s1 = 0
s2 = 0

die = DeterministicDie.new

while [s1, s2].all? { |s| s < 1_000 } do
  p1 += die.roll + die.roll + die.roll
  p1 %= 10
  s1 += p1 + 1

  next unless s1 < 1_000

  p2 += die.roll + die.roll + die.roll
  p2 %= 10
  s2 += p2 + 1
end

puts [s1, s2].min * die.rolls
