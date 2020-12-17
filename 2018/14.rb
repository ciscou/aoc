input = 846021

recipes = [3, 7]
elve_1 = 0
elve_2 = 1

loop do
  sum = recipes[elve_1] + recipes[elve_2]
  a, b = sum.divmod(10)
  recipes.push(a) unless a == 0
  break if recipes.length == input + 10
  recipes.push(b)
  break if recipes.length == input + 10

  elve_1 += recipes[elve_1] + 1
  elve_2 += recipes[elve_2] + 1

  elve_1 %= recipes.length
  elve_2 %= recipes.length
end

puts recipes.last(10).join("")

recipes = [3, 7]
elve_1 = 0
elve_2 = 1

target = input.to_s.chars.map(&:to_i)
last_6 = [nil, nil, nil, nil, 3, 7]

loop do
  sum = recipes[elve_1] + recipes[elve_2]
  a, b = sum.divmod(10)

  unless a == 0
    recipes.push(a)
    last_6.push(a)
    last_6.shift
  end
  break if last_6 == target

  recipes.push(b)
  last_6.push(b)
  last_6.shift
  break if last_6 == target

  elve_1 += recipes[elve_1] + 1
  elve_2 += recipes[elve_2] + 1

  elve_1 %= recipes.length
  elve_2 %= recipes.length
end

p recipes.length - target.length
