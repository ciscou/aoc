r0 = r1 = r2 = r3 = r4 = r5 = 0
r0 = 9959629

loop do
  r5 = r3 | 65536                  # 06
  r3 = 5557974                     # 07
  loop do
    r2 = r5 & 255                  # 08
    r3 += r2                       # 09
    r3 &= 16777215                 # 10
    r3 *= 65899                    # 11
    r3 &= 16777215                 # 12
    puts "uno 256, r5=#{r5}"
    r2 = 256 > r5 ? 1 : 0          # 13
    break if r2 == 1               # 14
    r2 = 0                         # 17
    loop do
      r1 = r2 + 1                  # 18
      r1 *= 256                    # 19
      puts "dos r1=#{r1}, r5=#{r5}"
      r1 = r1 > r5 ? 1 : 0         # 20
      break if r1 == 1             # 21
      r2 += 1                      # 24
    end                            # 25
    r5 = r2                        # 26
  end                              # 27
  puts "tres r3=#{r3}, r0=#{r0}"
  r2 = r3 == r0 ? 1 : 0            # 28
  break if r2 == 1                 # 29
end                                # 30
