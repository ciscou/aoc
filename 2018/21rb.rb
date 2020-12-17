r0 = r1 = r2 = r3 = r4 = r5 = 0




begin r5 = r3 | 65536 ; puts r5
  r3 = 5557974
  loop do r2 = r5 & 255
  r3 += r2
  r3 &= 16777215
  r3 *= 65899
  r3 &= 16777215
  r2 = 256 > r5 ? 1 : 0
  if r2 == 1


    r2 = 0
    r1 = r2 + 1
    r1 *= 256
    r1 = r1 > r5 ? 1 : 0
    if r1 == 1


      r2 += 1

    end ; r5 = r2
  else
    break

  end ; end ; r2 = r3 == r0 ? 1 : 0

end until r2 == 1
