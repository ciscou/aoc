input = <<EOS
Player 1:
41
26
29
11
50
38
42
20
13
9
40
43
10
24
35
30
23
15
31
48
27
44
16
12
14

Player 2:
18
6
32
37
25
21
33
28
7
8
45
46
49
5
19
2
39
4
17
3
22
1
34
36
47
EOS

p1 = []
p2 = []
pc = nil

input.lines.each do |line|
  line.chomp!

  next if line.empty?

  case line
  when "Player 1:" then pc = p1
  when "Player 2:" then pc = p2
  else pc << line.to_i
  end
end

while [p1, p2].none?(&:empty?)
  c1 = p1.shift
  c2 = p2.shift

  if c1 > c2
    p1.push(c1)
    p1.push(c2)
  else
    p2.push(c2)
    p2.push(c1)
  end
end

pc = p1.empty? ? p2 : p1

puts pc.reverse.map.with_index { |c, i| c * (i + 1) }.reduce(:+)
