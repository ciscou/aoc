input = <<EOS
50/41
19/43
17/50
32/32
22/44
9/39
49/49
50/39
49/10
37/28
33/44
14/14
14/40
8/40
10/25
38/26
23/6
4/16
49/25
6/39
0/50
19/36
37/37
42/26
17/0
24/4
0/36
6/9
41/3
13/3
49/21
19/34
16/46
22/33
11/6
22/26
16/40
27/21
31/46
13/2
24/7
37/45
49/2
32/11
3/10
32/49
36/21
47/47
43/43
27/19
14/22
13/43
29/0
33/36
2/6
EOS

# input = <<EOS
# 0/2
# 2/2
# 2/3
# 3/4
# 3/5
# 0/1
# 10/1
# 9/10
# EOS

components = input.lines.map do |line|
  line.chomp!

  line.split("/").map(&:to_i)
end

def find_valid_bridges_starting_with(prefix, components)
  prev_port = 0

  prefix.each do |ports|
    prev_port = ports.detect { |port| port != prev_port }
    prev_port ||= ports.first # symmetrical component
  end

  next_components = components.select { |ports| ports.any? { |port| port == prev_port } }

  next_components.inject([prefix]) do |res, ports|
    res += find_valid_bridges_starting_with(prefix + [ports], components - [ports])
  end
end

valid_bridges = find_valid_bridges_starting_with([], components)

valid_bridges.each do |bridge|
  puts "bridge: #{bridge.inspect}"
end

strongest = valid_bridges.max_by do |bridge|
  bridge.sum(&:sum)
end

longest = valid_bridges.sort_by do |bridge|
  [bridge.length, bridge.sum(&:sum)]
end.last

puts strongest.sum(&:sum)
puts longest.sum(&:sum)
