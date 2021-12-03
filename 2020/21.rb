INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

def part1
  foods = INPUT.map do |line|
    ingredients, allergens = line.split(" (")
    { ingredients: ingredients.split(" "), allergens: allergens[9..-2].split(", ") }
  end

  allergens = foods.flat_map { |f| f[:allergens] }.sort.uniq

  loop do
    found = []

    allergens.each do |allergen|
      foods_with_that_allergen = foods.select { |f| f[:allergens].include?(allergen) }
      ingredients_in_common = foods_with_that_allergen.map { |f| f[:ingredients] }.inject(:&)

      if ingredients_in_common.length == 1
        found << [allergen, ingredients_in_common.first]
      end
    end

    found.each do |allergen, ingredient|
      foods.each do |food|
        food[:allergens].delete(allergen)
        food[:ingredients].delete(ingredient)
      end

      allergens.delete(allergen)
    end

    break if found.empty?
  end

  foods
end

puts part1.select { |f| f[:allergens].empty? }.sum { |f| f[:ingredients].length }
