ingredients = [
  { name: "Sugar", capacity: 3, durability: 0, flavor: 0, texture: -3, calories: 2 },
  { name: "Sprinkles", capacity: -3, durability: 3, flavor: 0, texture: 0, calories: 9 },
  { name: "Candy", capacity: -1, durability: 0, flavor: 4, texture: 0, calories: 1 },
  { name: "Chocolate", capacity: 0, durability: 0, flavor: -2, texture: 2, calories: 8 }
]

sugar     = ingredients[0]
sprinkles = ingredients[1]
candy     = ingredients[2]
chocolate = ingredients[3]

highest_score = 0

(0..100).each do |sugar_amt|
  (0..100-sugar_amt).each do |sprinkles_amt|
    (0..100-sprinkles_amt-sugar_amt).each do |candy_amt|
      chocolate_amt = 100 - sugar_amt - sprinkles_amt - candy_amt

      capacity_score = sugar[:capacity] * sugar_amt + sprinkles[:capacity] * sprinkles_amt + candy[:capacity] * candy_amt + chocolate[:capacity] * chocolate_amt
      durability_score = sugar[:durability] * sugar_amt + sprinkles[:durability] * sprinkles_amt + candy[:durability] * candy_amt + chocolate[:durability] * chocolate_amt
      flavor_score = sugar[:flavor] * sugar_amt + sprinkles[:flavor] * sprinkles_amt + candy[:flavor] * candy_amt + chocolate[:flavor] * chocolate_amt
      texture_score = sugar[:texture] * sugar_amt + sprinkles[:texture] * sprinkles_amt + candy[:texture] * candy_amt + chocolate[:texture] * chocolate_amt
      calories = sugar[:calories] * sugar_amt + sprinkles[:calories] * sprinkles_amt + candy[:calories] * candy_amt + chocolate[:calories] * chocolate_amt

      total_score = [capacity_score, durability_score, flavor_score, texture_score].map do |score|
        [score, 0].max
      end.inject(:*)

      total_score = 0 unless calories == 500

      highest_score = total_score if total_score > highest_score
    end
  end
end

puts highest_score
