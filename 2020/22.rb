INPUT = <<EOS
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

def prepare_stacks
  p1 = []
  p2 = []
  pc = nil

  INPUT.lines.each do |line|
    line.chomp!

    next if line.empty?

    case line
    when "Player 1:" then pc = p1
    when "Player 2:" then pc = p2
    else pc << line.to_i
    end
  end

  [p1, p2]
end

def combat(p1, p2, recursive: false)
  seen = {}

  round = 0
  while [p1, p2].none?(&:empty?)
    round += 1

    if seen[[p1, p2].map { |p| p.join(",") }.join(";")]
      return p1
    end

    seen[[p1, p2].map { |p| p.join(",") }.join(";")] = true

    c1 = p1.shift
    c2 = p2.shift

    if recursive && p1.length >= c1 && p2.length >= c2
      newp1 = p1[0, c1].map(&:itself)
      newp2 = p2[0, c2].map(&:itself)

      winner = combat(newp1, newp2, recursive: recursive)

      if winner == newp1
        p1.push(c1)
        p1.push(c2)
      else
        p2.push(c2)
        p2.push(c1)
      end
    elsif c1 > c2
      p1.push(c1)
      p1.push(c2)
    else
      p2.push(c2)
      p2.push(c1)
    end
  end

  p1.empty? ? p2 : p1
end

def game(recursive:)
  p1, p2 = prepare_stacks

  pc = combat(p1, p2, recursive: recursive)

  pc.reverse.map.with_index { |c, i| c * (i + 1) }.reduce(:+)
end

def part1
  game(recursive: false)
end

def part2
  game(recursive: true)
end

puts part1
puts part2
