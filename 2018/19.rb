require "prime"

# result is the sum of all the numbers that divide the number that ends up in register 2

r0 = r1 = r2 = r3 = r4 = r5 = 0

r2 = 2 * 2 * 19 * 11 + 6 * 22 + 8

puts r2
factors = r2.prime_division.map { |base, exp| (exp + 1).times.map { |i| base ** i } }
first_factor, *rest_factors = factors
puts first_factor.product(*rest_factors).map { |ns| ns.inject(:*) }.sum

r2 += (27 * 28 + 29) * 30 * 14 * 32

puts r2
factors = r2.prime_division.map { |base, exp| (exp + 1).times.map { |i| base ** i } }
first_factor, *rest_factors = factors
puts first_factor.product(*rest_factors).map { |ns| ns.inject(:*) }.sum

# r1 = 1

# until r1 > r2
#   r5 = 1

#   until r5 > r2
#     if r1 * r5 == r2
#       r0 += r1
#     end

#     r5 += 1
#   end

#   r1 += 1
# end

# puts r0
