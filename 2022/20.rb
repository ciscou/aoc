INPUT = File.readlines('20.txt', chomp: true)

class CircularArray
  def initialize(size)
    @size = size
    @ary = Array.new(size, 0)
  end

  def [](idx)
    @ary[idx % @size]
  end

  def []=(idx, val)
    @ary[idx % @size] = val
  end

  def swap(idx1, idx2)
    self[idx1], self[idx2] = self[idx2], self[idx1]
  end

  def move(initial_position)
    idx = @ary.map(&:last).index(initial_position)
    entry = @ary[idx]

    d = entry[0] <=> 0
    entry[0].abs.times do
      next_idx = idx + d
      swap(idx, next_idx)
      idx = next_idx
    end
  end

  def solution
    idx0 = @ary.map(&:first).index(0)
    [1_000, 2_000, 3_000].sum { self[_1 + idx0][0] }
  end

  def inspect
    @ary.map(&:first).inspect
  end
end

numbers = INPUT.map(&:to_i)

ca = CircularArray.new(numbers.length)
numbers.each_with_index do |n, i|
  ca[i] = [n, i]
end
numbers.length.times do |i|
  ca.move(i)
end
puts ca.solution

ca = CircularArray.new(numbers.length)
numbers.each_with_index do |n, i|
  ca[i] = [n * 811589153, i]
end
10.times do
  numbers.length.times do |i|
    ca.move(i)
  end
end
puts ca.solution
