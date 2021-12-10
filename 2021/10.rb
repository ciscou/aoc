INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

PAIRS = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>'
}

CORRUPTED_SCORE = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}

INCOMPLETE_SCORE = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4
}

def corrupted_score(line)
  stack = []

  line.chars.each do |char|
    closing = PAIRS[char]
    if closing
     stack.push(closing)
    else
      expected = stack.pop

      if expected != char
        # puts "Expected #{expected.inspect} but got #{char.inspect}"
        return CORRUPTED_SCORE[char]
      end
    end
  end

  0
end

def incomplete_score(line)
  stack = []

  line.chars.each do |char|
    closing = PAIRS[char]
    if closing
     stack.push(closing)
    else
      expected = stack.pop

      if expected != char
        raise "Expected #{expected.inspect} but got #{char.inspect}"
      end
    end
  end

  score = 0

  until stack.empty?
    score *= 5
    score += INCOMPLETE_SCORE[stack.pop]
  end

  score
end

part1 = INPUT.sum do |line|
  corrupted_score(line)
end

puts part1

part2 = INPUT.map do |line|
  if corrupted_score(line) > 0
    nil
  else
    incomplete_score(line)
  end
end.compact.sort

puts part2[part2.length / 2]
