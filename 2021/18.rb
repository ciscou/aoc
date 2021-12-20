require "json"

INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class SnailfishNumber
  def initialize(number_or_pair, parent = nil)
    @parent = parent
    @ignore_bubbles_down = false

    if number_or_pair.is_a?(Numeric)
      @type = :number
      @number = number_or_pair
    else
      @type = :pair
      @left, @right = number_or_pair
      @left = SnailfishNumber.new(@left, self)
      @right = SnailfishNumber.new(@right, self)
    end
  end

  def to_s
    if @type == :number
      @number.to_s
    else
      "[#{@left.to_s},#{@right.to_s}]"
    end
  end

  def pairs
    if @type == :number
      @number
    else
      [@left.pairs, @right.pairs]
    end
  end

  attr_reader :type, :number, :parent, :left, :right

  def +(other)
    SnailfishNumber.new([pairs, other.pairs]).reduce
  end

  def reduce
    done = false

    until done
      done = !explode && !split
    end

    self
  end

  def magnitude
    if @type == :number
      @number
    else
      3 * @left.magnitude + 2 * @right.magnitude
    end
  end

  def explode(depth = 0)
    return false if @type == :number

    if depth > 3
      if @left.type == :number && @right.type == :number
        root = @parent
        root = root.parent until root.parent.nil?
        prev = root.find_prev_of(@left)
        nxt = root.find_next_of(@right)

        prev.increase_number(@left.number) if prev
        nxt.increase_number(@right.number) if nxt

        @type = :number
        @number = 0

        @left = nil
        @right = nil

        true
      else
        raise "there are pairs with depth > 0"
      end
    else
      @left.explode(depth + 1) || @right.explode(depth + 1)
    end
  end

  def split
    if @type == :number && @number > 9
      @left = SnailfishNumber.new(@number.fdiv(2).floor, self)
      @right = SnailfishNumber.new(@number.fdiv(2).ceil, self)

      @type = :pair
      @number = nil

      true
    elsif type == :pair
      @left.split || @right.split
    else
      false
    end
  end

  def increase_number(n)
    @number += n
  end

  def find_prev_of(node)
    last = nil

    dfs.each do |n|
      return last if n.object_id == node.object_id
      last = n if n.type == :number
    end

    nil
  end

  def find_next_of(node)
    found = false

    dfs.each do |n|
      return n if found && n.type == :number
      found ||= n.object_id == node.object_id
    end

    nil
  end

  def dfs
    if type == :number
      [self]
    else
      @left.dfs + [self] + @right.dfs
    end
  end
end

pairs = INPUT.map do |line|
  SnailfishNumber.new(JSON.parse(line))
end

sum = pairs.reduce(:+)
puts sum.magnitude

max = -Float::INFINITY

pairs.combination(2).each do |p1, p2|
  mag = (p1 + p2).magnitude
  max = mag if mag > max
  mag = (p2 + p1).magnitude
  max = mag if mag > max
end

puts max
