INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

part2 = true
pos = 0
res = 1

INPUT.each do |line|
  dir, steps, color = line.split
  steps = steps.to_f

  if part2
    dir = { "0" => "R", "1" => "D", "2" => "L", "3" => "U" }.fetch(color[-2])
    steps = color[2..-3].to_i(16).to_f
  end

  # stolen from https://www.reddit.com/r/adventofcode/comments/18l0qtr/comment/kdv18dn/
  case dir
  when "U"
    pos += steps
    res += steps / 2
  when "D"
    pos -= steps
    res += steps / 2
  when "L"
    res += steps / 2 - steps * pos
  when "R"
    res += steps / 2 + steps * pos
  else
    raise "invalid dir #{dir.inspect}"
  end
end

puts res
