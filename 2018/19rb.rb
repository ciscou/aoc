# 00 addi 4 16 4 # r4 += 16 (jump to 17)
# 01 seti 1 8 1  # r1 = 8
# 02 seti 1 3 5  # r5 = 1
# 03 mulr 1 5 3  # r3 = r1 * r5
# 04 eqrr 3 2 3  # r3 = r3 == r2 ? 1 : 0
# 05 addr 3 4 4  # r4 += r3 (jump to 07 if r3 == r2)
# 06 addi 4 1 4  # r4 += 1 (jump to 08)
# 07 addr 1 0 0  # r0 += r1
# 08 addi 5 1 5  # r5 += 1
# 09 gtrr 5 2 3  # r3 = r5 > r2 ? 1 : 0
# 10 addr 4 3 4  # r4 += r3 (jump to 12 if r5 > r2)
# 11 seti 2 2 4  # r4 = 2 (jump to 03)
# 12 addi 1 1 1  # r1 += 1
# 13 gtrr 1 2 3  # r3 = r1 > r2 ? 1 : 0
# 14 addr 3 4 4  # r4 += r3 (jump to 16 if r1 > r2)
# 15 seti 1 4 4  # r4 = 1 (jump to 02)
# 16 mulr 4 4 4  # r4 *= r4 (halt)
# 17 addi 2 2 2  # r2 += 2
# 18 mulr 2 2 2  # r2 *= 2
# 19 mulr 4 2 2  # r2 *= r4
# 20 muli 2 11 2 # r2 *= 11
# 21 addi 3 6 3  # r3 += 6
# 22 mulr 3 4 3  # r3 *= r4
# 23 addi 3 8 3  # r3 += 8
# 24 addr 2 3 2  # r2 += r3
# 25 addr 4 0 4  # r4 += r0 (jump to 27 if r0 == 1)
# 26 seti 0 1 4  # r4 = 1 (jump to 02)
# 27 setr 4 4 3  # r3 = r4
# 28 mulr 3 4 3  # r3 *= r4
# 29 addr 4 3 3  # r3 += r4
# 30 mulr 4 3 3  # r3 *= r4
# 31 muli 3 14 3 # r3 *= 14
# 32 mulr 3 4 3  # r3 *= r4
# 33 addr 2 3 2  # r2 += r3
# 34 seti 0 4 0  # r0 = 0
# 35 seti 0 7 4  # r4 = 7 (jump to 08)

r0 = r1 = r2 = r3 = r4 = r5 = 0

r2 += 2
r2 *= r2
r2 *= r4
r2 *= 11
r3 += 6
r3 *= 4
r3 += 8
r2 += r3
if r0 == 1
  r3 = r4
  r3 *= r4
  r3 += r4
  r3 *= r4
  r3 *= 14
  r3 *= r4
  r2 += r3
  r0 = 0
end
r1 = 8
begin
  puts "foo 1"
  r5 = 1
  begin
    puts "foo 2"
    if r1 * 5 == r2
      r0 += r1
    end
    r5 += 1
  end until r5 > r2
  puts "foo 3"
  r1 += 1
end until r1 > r2
puts "foo 4"

puts r0

#######################

r0 = r1 = r2 = r3 = r4 = r5 = 0

# 17 addi 2 2 2  # r2 += 2
# 18 mulr 2 2 2  # r2 *= 2
# 19 mulr 4 2 2  # r2 *= r4
# 20 muli 2 11 2 # r2 *= 11
# 21 addi 3 6 3  # r3 += 6
# 22 mulr 3 4 3  # r3 *= r4
# 23 addi 3 8 3  # r3 += 8
# 24 addr 2 3 2  # r2 += r3
#
# 25 addr 4 0 4  # if r0 == 1
# 27 setr 4 4 3  #   r3 = r4
# 28 mulr 3 4 3  #   r3 *= r4
# 29 addr 4 3 3  #   r3 += r4
# 30 mulr 4 3 3  #   r3 *= r4
# 31 muli 3 14 3 #   r3 *= 14
# 32 mulr 3 4 3  #   r3 *= r4
# 33 addr 2 3 2  #   r2 += r3
# 34 seti 0 4 0  #   r0 = 0
# 08 addi 5 1 5  #   r5 += 1
# 09 gtrr 5 2 3  #   r3 = r5 > r2 ? 1 : 0
# 10 addr 4 3 4  #   r4 += r3 (jump to 12 if r5 > r2)
# 11 seti 2 2 4  #   r4 = 2 (jump to 03)
# 12 addi 1 1 1  #   r1 += 1
# 13 gtrr 1 2 3  #   r3 = r1 > r2 ? 1 : 0
# 14 addr 3 4 4  #   r4 += r3 (jump to 16 if r1 > r2)
# 15 seti 1 4 4  #   r4 = 1 (jump to 02)
# 16 mulr 4 4 4  #   r4 *= r4 (halt)
#                # else
# 02 seti 1 3 5  #   r5 = 1
# 03 mulr 1 5 3  #   r3 = r1 * r5
# 04 eqrr 3 2 3  #   r3 = r3 == r2 ? 1 : 0
# 05 addr 3 4 4  #   if r3 == r2
# 07 addr 1 0 0  #     r0 += r1
#                #   end
# 08 addi 5 1 5  #   r5 += 1
# 09 gtrr 5 2 3  #   r3 = r5 > r2 ? 1 : 0
# 10 addr 4 3 4  #   r4 += r3 (jump to 12 if r5 > r2)
# 11 seti 2 2 4  #   r4 = 2 (jump to 03)
# 12 addi 1 1 1  #   r1 += 1
# 13 gtrr 1 2 3  #   r3 = r1 > r2 ? 1 : 0
# 14 addr 3 4 4  #   r4 += r3 (jump to 16 if r1 > r2)
# 15 seti 1 4 4  #   r4 = 1 (jump to 02)
# 16 mulr 4 4 4  #   r4 *= r4 (halt)
#                # end



# 00 addi 4 16 4 # r4 += 16 (jump to 17)
# 01 seti 1 8 1  # r1 = 8

puts r0
