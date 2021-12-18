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
        # ignoring_bubbles_down do
          bubble_up_left(@left.number)
          bubble_up_right(@right.number)
        # end

        # TODO add @left.number to the most-right node of parent.left
        # TODO add @right.number to the most-left node of parent.right
        # dyn programming?

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

      # puts "just splitted #{@number} into #{@left} and #{@right}"

      @type = :pair
      @number = nil

      true
    elsif type == :pair
      @left.split || @right.split
    else
      false
    end
  end

  def bubble_up_left(n)
    parent = @parent
    parent = parent.parent until parent.nil? || (parent.left && parent.left != self)

    return if parent.nil?

    ignoring_bubbles_down do
      puts "I am #{parent}, my left child is #{parent.left}, bubbling down right #{n}"
      parent.left.ignoring_bubbles_down { parent.left.bubble_down_right(n) }
    end
  end

  def bubble_up_right(n)
    parent = @parent
    parent = parent.parent until parent.nil? || (parent.right && parent.right != self)

    return if parent.nil?

    ignoring_bubbles_down do
      puts "I am #{parent}, mi right child is #{parent.right}, bubbling down left #{n}"
      parent.right.ignoring_bubbles_down { parent.right.bubble_down_left(n) }
    end
  end

  def bubble_down_left(n)
    return if @ignore_bubbles_down

    if @type == :number
      puts "bubbling down left, adding #{n} to #{@number}"
      @number += n
      true
    else
      @left.bubble_down_left(n) || @right.bubble_down_left(n)
    end
  end

  def bubble_down_right(n)
    return if @ignore_bubbles_down

    if @type == :number
      puts "bubbling down right, adding #{n} to #{@number}"
      @number += n
      true
    else
      @right.bubble_down_right(n) || @left.bubble_down_right(n)
    end
  end

  def ignoring_bubbles_down
    ignore_bubbles_down_was = @ignore_bubbles_down
    @ignore_bubbles_down = true
    res = yield
    @ignore_bubbles_down = ignore_bubbles_down_was
    res
  end
end

{
  [[1,2],[[3,4],5]] => 143,
  [[[[0,7],4],[[7,8],[6,0]]],[8,1]] => 1384,
  [[[[1,1],[2,2]],[3,3]],[4,4]] => 445,
  [[[[3,0],[5,3]],[4,4]],[5,5]] => 791,
  [[[[5,0],[7,4]],[5,5]],[6,6]] => 1137,
  [[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]] => 3488,
}.each do |pairs, expected_magnitude|
  magnitude = SnailfishNumber.new(pairs).magnitude
  raise "uh oh... expected #{expected_magnitude.inspect}, got #{magnitude.inspect}" unless magnitude == expected_magnitude
end

{
  [[[[[9,8],1],2],3],4] => [[[[0,9],2],3],4],
  [7,[6,[5,[4,[3,2]]]]] => [7,[6,[5,[7,0]]]],
  [[6,[5,[4,[3,2]]]],1] => [[6,[5,[7,0]]],3],
  [[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]] => [[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]],
  [[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]] => [[3,[2,[8,0]]],[9,[5,[7,0]]]],
}.each do |pairs, expected_pairs_after_explosion|
  n = SnailfishNumber.new(pairs)
  n.explode
  pairs_after_explosion = n.pairs
  raise "uh oh... expected #{expected_pairs_after_explosion}, got #{pairs_after_explosion}" unless pairs_after_explosion == expected_pairs_after_explosion
end

{
  [
    [[[[4,3],4],4],[7,[[8,4],9]]],
    [1,1],
  ] => [[[[0,7],4],[[7,8],[6,0]]],[8,1]],
  [
    [1,1],
    [2,2],
    [3,3],
    [4,4],
  ] => [[[[1,1],[2,2]],[3,3]],[4,4]],
  [
    [1,1],
    [2,2],
    [3,3],
    [4,4],
    [5,5],
  ] => [[[[3,0],[5,3]],[4,4]],[5,5]],
  [
    [1,1],
    [2,2],
    [3,3],
    [4,4],
    [5,5],
    [6,6],
  ] => [[[[5,0],[7,4]],[5,5]],[6,6]],
}.each do |list_of_pairs, expected_sum_pairs|
  sum_pairs = list_of_pairs.map { |pairs| SnailfishNumber.new(pairs) }.reduce(:+).pairs
  raise "uh oh... expected #{expected_sum_pairs.inspect}, got #{sum_pairs.inspect}" unless sum_pairs == expected_sum_pairs
end

# slightly larger example

{
  [
    [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],
    [7,[[[3,7],[4,3]],[[6,3],[8,8]]]],
  ] => [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]],
}.each do |list_of_pairs, expected_sum_pairs|
  # TODO
  sum_pairs = list_of_pairs.map { |pairs| SnailfishNumber.new(pairs) }.reduce(:+).pairs
  puts sum_pairs.inspect
  puts expected_sum_pairs.inspect
  puts "uh oh... expected #{expected_sum_pairs.inspect}, got #{sum_pairs.inspect}" unless sum_pairs == expected_sum_pairs
end

pairs = INPUT.map do |line|
  SnailfishNumber.new(JSON.parse(line))
end

sum = pairs.reduce(:+)
puts sum
puts sum.magnitude
