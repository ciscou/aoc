INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

[4, 14].each do |packet_length|
  offset = packet_length - 1
  INPUT.first.chars.each_cons(packet_length).detect do |packet|
    offset += 1
    packet.uniq.size == packet_length
  end
  puts offset
end
