INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

flag = true

part1 = 0
part2 = 0

INPUT.each do |line|
  line.scan(/(do)\(\)|(don't)\(\)|mul\((\d{1,3}),(\d{1,3})\)/).each do |match|
    if match[0]
      flag = true
    elsif match[1]
      flag = false
    else
      a, b = match[2..3].map(&:to_i)
      part1 += a * b
      part2 += a * b if flag
    end
  end
end

puts part1
puts part2
