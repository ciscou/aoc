r0 = r1 = r2 = r3 = r4 = r5 = 0

part2 = false

r2 = 2 * 2 * 19 * 11 + 6 * 22 + 8
r2 += (27 * 28 + 29) * 30 * 14 * 32 if part2

r1 = 1
loop do
  r5 = 1
  loop do
    r3 = r1 * r5
    r3 = r3 == r2 ? 1 : 0
    if r3 == 1
      r0 += r1
    end
    r5 += 1
    r3 = r5 > r2 ? 1 : 0
    break if r3 == 1
  end
  r1 += 1
  r3 = r1 > r2 ? 1 : 0
  break if r3 == 1
end

puts r0
