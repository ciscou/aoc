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

def parsing_errors(line)
  stack = []

  line.chars.each do |char|
    closing = PAIRS[char]
    if closing
     stack.push(closing)
    elsif char != stack.pop
      return { corrupted: char }
    end
  end

  if stack.empty?
    nil
  else
    { incomplete: stack }
  end
end

def corrupted_score(line)
  errors = parsing_errors(line)
  corrupted = errors[:corrupted]

  return unless corrupted

  CORRUPTED_SCORE[corrupted]
end

def incomplete_score(line)
  errors = parsing_errors(line)
  incomplete = errors[:incomplete]

  return unless incomplete

  incomplete.reverse.inject(0) do |score, char|
    score * 5 + INCOMPLETE_SCORE[char]
  end
end

def part1
  INPUT.map do |line|
    corrupted_score(line)
  end.compact.sum
end

def part2
  scores = INPUT.map do |line|
    incomplete_score(line)
  end.compact.sort

  scores[scores.length / 2]
end

puts part1
puts part2
