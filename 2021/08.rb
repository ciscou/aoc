INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def delete_with_extra(connections, segments)
  connection = connections.detect { |c| segments.all? { |s| c.include?(s) } }
  connections.delete(connection)

  [connection, (connection - segments).first]
end

def delete_first_matching(connections, &block)
  connection = connections.detect(&block)
  connections.delete(connection)

  connection
end

part1 = 0
part2 = 0

INPUT.each do |line|
  connections, outputs = line.split(" | ")

  segments_for = {}
  mapping = {}
  by_length = connections.split(" ").each_with_object(Hash.new { |h, k| h[k] = [] }) do |connection, h|
    h[connection.length] << connection.chars.sort
  end

  segments_for[1] = by_length[2].shift
  segments_for[4] = by_length[4].shift
  segments_for[7] = by_length[3].shift
  segments_for[8] = by_length[7].shift

  mapping["a"] = (segments_for[7] - segments_for[1]).first

  segments_for[9], mapping["g"] = delete_with_extra(by_length[6], segments_for[4] + mapping.values_at("a"))

  segments_for[3], mapping["d"] = delete_with_extra(by_length[5], segments_for[1] + mapping.values_at("a", "g"))

  segments_for[0] = by_length[6].delete(segments_for[8] - [mapping["d"]])

  segments_for[6] = by_length[6].shift

  mapping["c"] = (segments_for[8] - segments_for[6]).first

  segments_for[2] = delete_first_matching(by_length[5]) { |c| c.include? mapping["c"] }

  segments_for[5] = by_length[5].shift

  number_for = segments_for.invert

  part1_inc = 0
  part2_inc = 0

  outputs.split(" ").each do |output|
    number = number_for[output.chars.sort]

    part1_inc += 1 if [1, 4, 7, 8].include?(number)
    part2_inc = part2_inc * 10 + number
  end

  part1 += part1_inc
  part2 += part2_inc
end

puts part1
puts part2
