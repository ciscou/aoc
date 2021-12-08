INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def detect_and_delete(connections, &block)
  connection = connections.detect(&block)
  connections.delete(connection)
end

parts = INPUT.map do |line|
  connections, outputs = line.split(" | ")

  by_length = connections.split(" ").each_with_object(Hash.new { |h, k| h[k] = [] }) do |connection, h|
    h[connection.length] << connection.chars.sort
  end

  segments_for = {}

  segments_for[1] = by_length[2].shift
  segments_for[4] = by_length[4].shift
  segments_for[7] = by_length[3].shift
  segments_for[8] = by_length[7].shift
  segments_for[3] = detect_and_delete(by_length[5]) { |c| (segments_for[1] - c).empty? }
  segments_for[9] = detect_and_delete(by_length[6]) { |c| (segments_for[4] - c).empty? }
  segments_for[5] = detect_and_delete(by_length[5]) { |c| (c - segments_for[9]).empty? }
  segments_for[2] = by_length[5].shift
  segments_for[6] = detect_and_delete(by_length[6]) { |c| (segments_for[5] - c).empty? }
  segments_for[0] = by_length[6].shift

  number_for = segments_for.invert

  outputs.split(" ").map do |output|
    number = number_for[output.chars.sort]

    [[1, 4, 7, 8].include?(number), number]
  end
end

puts parts.sum { |part| part.count(&:first) }
puts parts.sum { |part| part.map(&:last).join("").to_i }
