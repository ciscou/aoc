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

  attr_reader :inspected_items, :worry_levels

  def turn
    @worry_levels.each do |worry_level|
      @inspected_items += 1

      worry_level = case @operation
                    when "+" then worry_level + @operator
                    when "*" then worry_level * @operator
                    when "^" then worry_level ** @operator
                    else unreachable
                    end
      worry_level /= 3

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

  def round
    @monkeys.each do |monkey|
      monkey.turn do |thrown_item, to|
        @monkeys[to].receive(thrown_item)
      end
    end
  end

  def business
    @monkeys.map(&:inspected_items).max(2).reduce(:*)
  end
end

monkeys = Monkeys.new(INPUT)
20.times { monkeys.round }
puts monkeys.business
