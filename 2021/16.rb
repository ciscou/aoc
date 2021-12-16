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
    when 4
      done = false
      until done
        group = shift(5)
        h, n = group.divmod(16)

        done = true if h == 0
      end
    else
      length_type = shift(1)

      case length_type
      when 0
        sub_packets_length = shift(15)
        offset_was = @offset

        until @offset >= offset_was + sub_packets_length
          parse_packet
        end
      when 1
        sub_packets_count = shift(11)
        sub_packets_count.times do
          parse_packet
        end
      else
        raise "Invalid length_type #{length_type} at offset #{@offset - 1}"
      end
    end
  end

  def shift(n)
    bits = @bits[@offset, n]
    @offset += n

    bits.join("").to_i(2)
  end
end

parser = Parser.new(INPUT.first)
parser.parse
puts parser.version_sum
