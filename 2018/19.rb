r0 = r1 = r2 = r3 = r4 = r5 = 0

part2 = false

r2 = 2 * 2 * 19 * 11 + 6 * 22 + 8
r2 += (27 * 28 + 29) * 30 * 14 * 32 if part2

r1 = 1

until r1 > r2
  r5 = 1

  until r5 > r2
    if r1 * r5 == r2
      r0 += r1
    end

    r5 += 1
  end

  r1 += 1
end

puts r0
