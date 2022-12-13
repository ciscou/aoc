INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Packet
  def initialize(data)
    @data = data
  end

  attr_reader :data

  def <=>(other)
    case [data.class, other.data.class]
    when [Integer, Integer]
      data <=> other.data
    when [Integer, Array]
      Packet.new([data]) <=> other
    when [Array, Integer]
      self <=> Packet.new([other.data])
    when [Array, Array]
      packets, other_packets = [data, other.data].map { |data| data.map { Packet.new(_1) } }

      packets <=> other_packets
    else
      unreachable
    end
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

dividers = [Packet.new([[2]]), Packet.new([[6]])]
packets = pairs.flatten
packets += dividers
packets.sort!

part2 = dividers.map { |divider| packets.index(divider) + 1 }.reduce(:*)
puts part2
