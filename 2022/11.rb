INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Monkey
  def initialize(input)
    _, starting, operation, *test = input

    @worry_levels = starting.split(": ").last.split(", ").map(&:to_i)
    @operation = case operation
                 when %r{old \+ (\d+)$} then ->(old) { old + $1.to_i }
                 when %r{old \* (\d+)$} then ->(old) { old * $1.to_i }
                 when %r{old \* old$}   then ->(old) { old * old }
                 else unreachable
                 end
    @modulo, @if_true, @if_false = test.map { |s| s.split.last.to_i }

    @inspected_items = 0
  end

  attr_reader :inspected_items, :modulo

  def turn(part:)
    until @worry_levels.empty?
      @inspected_items += 1

      worry_level = @operation.call(@worry_levels.shift)
      worry_level /= 3 if part == 1

      yield worry_level, worry_level % @modulo == 0 ? @if_true : @if_false
    end
  end

  def receive(worry_level)
    @worry_levels << worry_level
  end
end

class Monkeys
  def initialize(input)
    @monkeys = input.chunk { |l| l.empty? && nil }.map { |_, chunk| Monkey.new(chunk) }
  end

  def round(part:)
    @monkeys.each do |monkey|
      monkey.turn(part: part) do |worry_level, to|
        worry_level %= moduli_prod if part == 2
        @monkeys[to].receive(worry_level)
      end
    end
  end

  def business
    @monkeys.map(&:inspected_items).max(2).reduce(:*)
  end

  private

  def moduli_prod
    @moduli_prod ||= @monkeys.map(&:modulo).reduce(:*)
  end
end

monkeys = Monkeys.new(INPUT)
20.times { monkeys.round(part: 1) }
puts monkeys.business

monkeys = Monkeys.new(INPUT)
10_000.times { monkeys.round(part: 2) }
puts monkeys.business
