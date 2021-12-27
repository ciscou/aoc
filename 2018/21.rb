min = Float::INFINITY
max = -Float::INFINITY

while s = gets
  r0 = s.to_i

  loops = 0
  r3 = r5 = 0

  begin
    r5 = r3 | 65536                  # 06
    r3 = 5557974                     # 07
    begin
      loops += 1
      r3 += r5 & 255                 # 08, 09
      r3 &= 16777215                 # 10
      r3 *= 65899                    # 11
      r3 &= 16777215                 # 12
      r5 /= 256                      # 17-26
    end until r5 == 0                # 27
    # puts r3 this was to generate a list of numbers that halt
  end until r3 == r0                 # 28, 29, 30

  if loops < min
    min = loops
    min_r0 = r0
  end

  if loops > max
    max = loops
    max_r0 = r0
  end
end

puts "min: #{min_r0}"
puts "max: #{max_r0}"
