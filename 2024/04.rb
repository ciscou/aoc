INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

WORD = "XMAS"

part1 = 0

INPUT.length.times do |row|
  INPUT[row].length.times do |col|
    words = []

    if row + WORD.length <= INPUT.length
      words << WORD.length.times.map { INPUT[row + _1][col] }.join
    end

    if col + WORD.length <= INPUT[row].length
      words << WORD.length.times.map { INPUT[row][col + _1] }.join
    end

    if row + WORD.length <= INPUT.length && col + WORD.length <= INPUT[row].length
      words << WORD.length.times.map { INPUT[row + _1][col + _1] }.join
    end

    if row + WORD.length <= INPUT.length && col + 1 >= WORD.length
      words << WORD.length.times.map { INPUT[row + _1][col - _1] }.join
    end

    part1 += words.count { _1 == WORD }
    part1 += words.count { _1.reverse == WORD }
  end
end

puts part1

part2 = 0

(INPUT.length - 2).times do |row|
  (INPUT[row].length - 2).times do |col|
    w1 = "#{INPUT[row][col]}#{INPUT[row+1][col+1]}#{INPUT[row+2][col+2]}"
    w2 = "#{INPUT[row][col+2]}#{INPUT[row+1][col+1]}#{INPUT[row+2][col]}"

    if w1 == "MAS" || w1 == "SAM"
      if w2 == "MAS" || w2 == "SAM"
        part2 += 1
      end
    end
  end
end

puts part2
