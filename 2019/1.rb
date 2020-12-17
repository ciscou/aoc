def calculate_fuel(weight)
  fuel = weight / 3 - 2

  if fuel > 0
    fuel + calculate_fuel(fuel)
  else
    0
  end
end

sum = 0

while s = gets
  s.chomp!

  weight = s.to_i

  sum += calculate_fuel(weight)
end

puts sum
