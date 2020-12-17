recipes = {}
leftovers = {}
leftovers.default = 0

while s = gets
  s.chomp!

  input, output = s.split(" => ")

  ingredients = input.split(", ").map do |ingredient|
    quantity, ingredient = ingredient.split(" ")
    [quantity.to_i, ingredient]
  end

  quantity, recipe = output.split(" ")

  recipes[recipe] = { ingredients: ingredients, quantity: quantity.to_i }
end

def calculate_ore_for(recipes, leftovers, recipe, quantity)
  return quantity if recipe == "ORE"

  if leftovers[recipe] >= quantity
    leftovers[recipe] -= quantity
    0
  else
    quantity -= leftovers[recipe]
    leftovers[recipe] = 0

    r = recipes[recipe]



    res = 0
    produced = 0

    while produced < quantity
      res += r[:ingredients].sum do |i|
        calculate_ore_for(recipes, leftovers, i.last, i.first)
      end
      produced += r[:quantity]
    end




#   n = (quantity.to_f / r[:quantity]).ceil
#   res = n * r[:ingredients].sum do |i|
#     calculate_ore_for(recipes, leftovers, i.last, i.first)
#   end
#   produced = n * r[:quantity]





    leftovers[recipe] = produced - quantity

    res
  end
end

def maximize(recipes, leftovers, recipe, ore)
  maximize2(recipes, leftovers, recipe, ore, 1, 100)
end

def maximize2(recipes, leftovers, recipe, ore, from, to)
  puts calculate_ore_for(recipes, leftovers, recipe, from)
  puts calculate_ore_for(recipes, leftovers, recipe, to)
end

puts calculate_ore_for(recipes, leftovers, "FUEL", 1)
puts calculate_ore_for(recipes, leftovers, "FUEL", 10)
puts calculate_ore_for(recipes, leftovers, "FUEL", 100)
puts calculate_ore_for(recipes, leftovers, "FUEL", 1000)
puts calculate_ore_for(recipes, leftovers, "FUEL", 10000)
puts calculate_ore_for(recipes, leftovers, "FUEL", 100000)

# puts maximize(recipes, leftovers, "FUEL", 1_000_000_000_000)
