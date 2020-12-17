input = <<EOS
rotate based on position of letter a
swap letter g with letter d
move position 1 to position 5
reverse positions 6 through 7
move position 5 to position 4
rotate based on position of letter b
reverse positions 6 through 7
swap letter h with letter f
swap letter e with letter c
reverse positions 0 through 7
swap position 6 with position 4
rotate based on position of letter e
move position 2 to position 7
swap position 6 with position 4
rotate based on position of letter e
reverse positions 2 through 3
rotate right 2 steps
swap position 7 with position 1
move position 1 to position 2
move position 4 to position 7
move position 5 to position 0
swap letter e with letter f
move position 4 to position 7
reverse positions 1 through 7
rotate based on position of letter g
move position 7 to position 4
rotate right 6 steps
rotate based on position of letter g
reverse positions 0 through 5
reverse positions 0 through 7
swap letter c with letter f
swap letter h with letter f
rotate right 7 steps
rotate based on position of letter g
rotate based on position of letter c
swap position 1 with position 4
move position 7 to position 3
reverse positions 2 through 6
move position 7 to position 0
move position 7 to position 1
move position 6 to position 7
rotate right 5 steps
reverse positions 0 through 6
move position 1 to position 4
rotate left 3 steps
swap letter d with letter c
move position 4 to position 5
rotate based on position of letter f
rotate right 1 step
move position 7 to position 6
swap position 6 with position 0
move position 6 to position 2
rotate right 1 step
swap position 1 with position 6
move position 2 to position 6
swap position 2 with position 1
reverse positions 1 through 7
move position 4 to position 1
move position 7 to position 0
swap position 6 with position 7
rotate left 1 step
reverse positions 0 through 4
rotate based on position of letter c
rotate based on position of letter b
move position 2 to position 1
rotate right 0 steps
swap letter b with letter d
swap letter f with letter c
swap letter d with letter a
swap position 7 with position 6
rotate right 0 steps
swap position 0 with position 3
swap position 2 with position 5
swap letter h with letter f
reverse positions 2 through 3
rotate based on position of letter c
rotate left 2 steps
move position 0 to position 5
swap position 2 with position 3
rotate right 1 step
rotate left 2 steps
move position 0 to position 4
rotate based on position of letter c
rotate based on position of letter g
swap position 3 with position 0
rotate right 3 steps
reverse positions 0 through 2
move position 1 to position 2
swap letter e with letter c
rotate right 7 steps
move position 0 to position 7
rotate left 2 steps
reverse positions 0 through 4
swap letter e with letter b
reverse positions 2 through 7
rotate right 5 steps
swap position 2 with position 4
swap letter d with letter g
reverse positions 3 through 4
reverse positions 4 through 5
EOS

"fbgdceah".chars.permutation.each do |chars|
  s = chars.join("")

  input.lines.each do |line|
    line.chomp!

    case line
    when /^swap position ([0-9]+) with position ([0-9]+)$/
      x = $1.to_i
      y = $2.to_i
      chars[x], chars[y] = chars[y], chars[x]
    when /^swap letter ([a-z]) with letter ([a-z])$/
      x = $1
      y = $2
      chars.map! do |c|
        if c == x
          y
        elsif c == y
          x
        else
          c
        end
      end
    when /^rotate left ([0-9]+) steps?$/
      steps = $1.to_i
      steps.times do
        chars.push chars.shift
      end
    when /^rotate right ([0-9]+) steps?$/
      steps = $1.to_i
      steps.times do
        chars.unshift chars.pop
      end
    when /^rotate based on position of letter ([a-z])$/
      letter = $1
      index = chars.index(letter)
      steps = index + 1
      steps += 1 if index >= 4
      steps.times do
        chars.unshift chars.pop
      end
    when /^reverse positions ([0-9]+) through ([0-9]+)$/
      x = $1.to_i
      y = $2.to_i
      chars[x..y] = chars[x..y].reverse
    when /^move position ([0-9]+) to position ([0-9]+)$/
      x = $1.to_i
      y = $2.to_i
      c = chars.slice!(x)
      chars.insert(y, c)
    else
      raise "cannot parse line #{line.inspect}"
    end
  end

  puts s if chars.join("") == "fbgdceah"
end
