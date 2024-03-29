INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Parser
  def initialize(input)
    @bits = input.chars.map { |char| char.to_i(16).to_s(2).rjust(4, "0") }.join("").chars.map(&:to_i)
    @offset = 0
    @version_sum = 0
  end

  attr_reader :version_sum

  def parse
    parse_packet
  end

  private

  def parse_packet
    version = shift(3)
    type = shift(3)

    @version_sum += version

    case type
    when 0
      SumPacket.new(parse_sub_packets)
    when 1
      ProductPacket.new(parse_sub_packets)
    when 2
      MinimumPacket.new(parse_sub_packets)
    when 3
      MaximumPacket.new(parse_sub_packets)
    when 4
      parse_literal_packet
    when 5
      GreaterThanPacket.new(parse_sub_packets)
    when 6
      LessThanPacket.new(parse_sub_packets)
    when 7
      EqualToPacket.new(parse_sub_packets)
    else
      raise "Invalid type #{type} at offset #{@offset}"
    end
  end

  def parse_literal_packet
    done = false
    value = 0

    until done
      group = shift(5)
      h, n = group.divmod(16)

      value *= 16
      value += n

      done = h == 0
    end

    LiteralPacket.new(value)
  end

  def parse_sub_packets
    length_type = shift(1)

    case length_type
    when 0
      sub_packets_length = shift(15)
      offset_was = @offset

      res = []

      until @offset >= offset_was + sub_packets_length
        res << parse_packet
      end

      res
    when 1
      sub_packets_count = shift(11)

      sub_packets_count.times.map do
        parse_packet
      end
    else
      raise "Invalid length_type #{length_type} at offset #{@offset}"
    end
  end

  def shift(n)
    bits = @bits[@offset, n]
    @offset += n

    bits.join("").to_i(2)
  end
end

LiteralPacket = Struct.new(:value) do
  def print(indent = 0)
    puts ("  " * indent) + value.to_s
  end

  def to_s
    value.to_s
  end
end

SumPacket = Struct.new(:sub_packets) do
  def value
    sub_packets.map(&:value).sum
  end

  def print(indent = 0)
    puts ("  " * indent) + "+"
    sub_packets.each { |sp| sp.print(indent + 1) }
  end

  def to_s
    "(#{sub_packets.map(&:to_s).join(" + ")})"
  end
end

ProductPacket = Struct.new(:sub_packets) do
  def value
    sub_packets.map(&:value).inject(:*)
  end

  def print(indent = 0)
    puts ("  " * indent) + "*"
    sub_packets.each { |sp| sp.print(indent + 1) }
  end

  def to_s
    "(#{sub_packets.map(&:to_s).join(" * ")})"
  end
end

MinimumPacket = Struct.new(:sub_packets) do
  def value
    sub_packets.map(&:value).min
  end

  def print(indent = 0)
    puts ("  " * indent) + "min"
    sub_packets.each { |sp| sp.print(indent + 1) }
  end

  def to_s
    "[#{sub_packets.map(&:to_s).join(", ")}].min"
  end
end

MaximumPacket = Struct.new(:sub_packets) do
  def value
    sub_packets.map(&:value).max
  end

  def print(indent = 0)
    puts ("  " * indent) + "max"
    sub_packets.each { |sp| sp.print(indent + 1) }
  end

  def to_s
    "[#{sub_packets.map(&:to_s).join(", ")}].max"
  end
end

GreaterThanPacket = Struct.new(:sub_packets) do
  def value
    a, b = sub_packets.map(&:value)
    a > b ? 1 : 0
  end

  def print(indent = 0)
    puts ("  " * indent) + ">"
    sub_packets.each { |sp| sp.print(indent + 1) }
  end

  def to_s
    a, b = sub_packets
    "(#{a} > #{b} ? 1 : 0)"
  end
end

LessThanPacket = Struct.new(:sub_packets) do
  def value
    a, b = sub_packets.map(&:value)
    a < b ? 1 : 0
  end

  def print(indent = 0)
    puts ("  " * indent) + "<"
    sub_packets.each { |sp| sp.print(indent + 1) }
  end

  def to_s
    a, b = sub_packets
    "(#{a} < #{b} ? 1 : 0)"
  end
end

EqualToPacket = Struct.new(:sub_packets) do
  def value
    a, b = sub_packets.map(&:value)
    a == b ? 1 : 0
  end

  def print(indent = 0)
    puts ("  " * indent) + "=="
    sub_packets.each { |sp| sp.print(indent + 1) }
  end

  def to_s
    a, b = sub_packets
    "(#{a} == #{b} ? 1 : 0)"
  end
end

parser = Parser.new(INPUT.first)
packet = parser.parse
puts parser.version_sum
puts packet.value
