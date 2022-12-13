INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Packet
  def initialize(data)
    @data = data
  end

  attr_reader :data

  def <=>(other)
    puts "comparing #{inspect} and #{other.inspect}"

    kk = case [data.class, other.data.class]
    when [Integer, Integer]
      data <=> other.data
    when [Integer, Array]
      Packet.new([data]) <=> other
    when [Array, Integer]
      self <=> Packet.new([other.data])
    when [Array, Array]
      res = data.length < other.data.length ? -1 : 0
      data.zip(other.data) do |datum, other_datum|
        return 1 if other_datum.nil?

        cmp = Packet.new(datum) <=> Packet.new(other_datum)
        return cmp unless cmp == 0
      end
      res
    else
      unreachable
    end

    puts "comparing #{inspect} and #{other.inspect}: #{kk.inspect}"

    kk
  end
end

pairs = INPUT.chunk { |line| line.empty? && nil }.map { |_, data| data.map { Packet.new(eval(_1)) } }

part1 = pairs.each_with_index.sum do |pair, index|
  packet1, packet2 = pair

  if (packet1 <=> packet2) == -1
    index + 1
  else
    0
  end
end
puts part1
