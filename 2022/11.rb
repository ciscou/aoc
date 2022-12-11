INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Monkey
  def initialize(input)
    _, starting, operation, test, if_true, if_false = input

    @worry_levels = starting.split(": ").last.split(", ").map(&:to_i)
    @operation, @operator = operation.split.last(2)
    if @operator == "old"
      @operation = @operation == "+" ? "*" : "^"
      @operator = 2
    else
      @operator = @operator.to_i
    end
    @test = test.split.last.to_i
    @if_true = if_true.split.last.to_i
    @if_false = if_false.split.last.to_i

    @inspected_items = 0
  end

  attr_reader :inspected_items, :test

  def turn(part:)
    @worry_levels.each do |worry_level|
      @inspected_items += 1

      worry_level = case @operation
                    when "+" then worry_level + @operator
                    when "*" then worry_level * @operator
                    when "^" then worry_level ** @operator
                    else unreachable
                    end
      worry_level /= 3 if part == 1

      yield worry_level, worry_level % @test == 0 ? @if_true : @if_false
    end

    @worry_levels = []
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
        worry_level %= tests_prod if part == 2
        @monkeys[to].receive(worry_level)
      end
    end
  end

  def business
    @monkeys.map(&:inspected_items).max(2).reduce(:*)
  end

  private

  def tests_prod
    @tests_prod ||= @monkeys.map(&:test).reduce(:*)
  end
end

monkeys = Monkeys.new(INPUT)
20.times { monkeys.round(part: 1) }
puts monkeys.business

monkeys = Monkeys.new(INPUT)
10_000.times { monkeys.round(part: 2) }
puts monkeys.business
