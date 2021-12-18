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

        # puts "I am #{self}, left is #{@left}, right is #{@right}"
        # puts "I am #{self}, prev is #{prev}, next is #{nxt}"
        # $stdin.gets
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
    root = @parent
    root = root.parent until root.parent.nil?
    prev = root.find_prev_of(left)

    puts "root is #{root}, prev of #{left} is #{prev}"

    prev.increase_number(n) unless prev.nil?
  end

  def bubble_up_right(n)
    root = @parent
    root = root.parent until root.parent.nil?
    nxt = root.find_next_of(right)

    puts "root is #{root}, next of #{right} is #{nxt}"

    nxt.increase_number(n) unless nxt.nil?
  end

  def increase_number(n)
    @number += n
  end

  def find_prev_of(node)
    last = nil

    dfs.each do |n|
      # puts n
      return last if n.object_id == node.object_id
      last = n if n.type == :number
    end

    nil
  end

  def find_next_of(node)
    found = false

    dfs.each do |n|
      # puts n
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
  raise "uh oh... expected #{expected_sum_pairs.inspect}, got #{sum_pairs.inspect}" unless sum_pairs == expected_sum_pairs
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
