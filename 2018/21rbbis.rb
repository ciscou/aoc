max = 5
1_000_000_000.times do |i|
  r0 = r1 = r2 = r3 = r4 = r5 = 0
  r0 = i
  cnt = 0

  begin
    break if cnt > max
    r5 = r3 | 65536
    r3 = 5557974
    loop do
      r2 = r5 & 255
      r3 += r2
      r3 &= 16777215
      r3 *= 65899
      r3 &= 16777215
      r2 = 256 > r5 ? 1 : 0
      if r2 == 1
        break
      else
        r2 = r5 / 256
        cnt += 1
      end
      r5 = r2
    end
    r2 = r3 == r0 ? 1 : 0
  end until r2 == 1

  max = cnt if cnt < max
  p [i, cnt].inspect unless cnt > max
end
