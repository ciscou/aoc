INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def first_digit(s, part2: false)
  min = Float::INFINITY
  digit = nil

  {
    "1" => "one",
    "2" => "two",
    "3" => "three",
    "4" => "four",
    "5" => "five",
    "6" => "six",
    "7" => "seven",
    "8" => "eight",
    "9" => "nine",
  }.each do |k, v|
    i = s.index(k)
    if i && i < min
      min = i
      digit = k
    end

    i = s.index(v)
    if part2 && i && i < min
      min = i
      digit = k
    end
  end

  digit
end

def last_digit(s, part2: false)
  max = -Float::INFINITY
  digit = nil

  {
    "1" => "one",
    "2" => "two",
    "3" => "three",
    "4" => "four",
    "5" => "five",
    "6" => "six",
    "7" => "seven",
    "8" => "eight",
    "9" => "nine",
  }.each do |k, v|
    i = s.rindex(k)
    if i && i > max
      max = i
      digit = k
    end

    i = s.rindex(v)
    if part2 && i && i + v.length - 1 > max
      max = i
      digit = k
    end
  end

  digit
end

puts INPUT.map { first_digit(_1) + last_digit(_1) }.map(&:to_i).sum
puts INPUT.map { first_digit(_1, part2: true) + last_digit(_1, part2: true) }.map(&:to_i).sum
