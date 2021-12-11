INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def prepare_stacks
  p1 = []
  p2 = []
  pc = nil

  INPUT.each do |line|
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

  while [p1, p2].none?(&:empty?)
    if seen[[p1, p2].map { |p| p.join(",") }.join(";")]
      return p1
    end

    seen[[p1, p2].map { |p| p.join(",") }.join(";")] = true

    c1 = p1.shift
    c2 = p2.shift

    winner = if recursive && p1.length >= c1 && p2.length >= c2
               newp1 = p1[0, c1]
               newp2 = p2[0, c2]

               winner = combat(newp1, newp2, recursive: recursive)

               winner == newp1 ? p1 : p2
             elsif c1 > c2
               p1
             else
               p2
             end

    if winner == p1
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
