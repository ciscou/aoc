BOSS_STATS = {
  hp: 100,
  dmg: 8,
  armor: 2
}

WEAPONS = [
  { name: "Dagger",     cost:  8, dmg: 4, armor: 0 },
  { name: "Shortsword", cost: 10, dmg: 5, armor: 0 },
  { name: "Warhammer",  cost: 25, dmg: 6, armor: 0 },
  { name: "Longsword",  cost: 40, dmg: 7, armor: 0 },
  { name: "Greataxe",   cost: 74, dmg: 8, armor: 0 }
]

ARMOR = [
  { name: "Leather",    cost:  13, dmg: 0, armor: 1 },
  { name: "Chainmail",  cost:  31, dmg: 0, armor: 2 },
  { name: "Splintmail", cost:  53, dmg: 0, armor: 3 },
  { name: "Bandedmail", cost:  75, dmg: 0, armor: 4 },
  { name: "Platemail",  cost: 102, dmg: 0, armor: 5 }
]

RINGS = [
  {name: "Damage +1",  cost:  25, dmg: 1, armor: 0 },
  {name: "Damage +2",  cost:  50, dmg: 2, armor: 0 },
  {name: "Damage +3",  cost: 100, dmg: 3, armor: 0 },
  {name: "Defense +1", cost:  20, dmg: 0, armor: 1 },
  {name: "Defense +2", cost:  40, dmg: 0, armor: 2 },
  {name: "Defense +3", cost:  80, dmg: 0, armor: 3 }
]

min_gold = 999_999_999_999
min_items = []

[1].each do |weapons_amount|
  [0, 1].each do |armor_amount|
    [0, 1, 2].each do |rings_amount|
      WEAPONS.combination(weapons_amount).each do |weapons|
        ARMOR.combination(armor_amount).each do |armor|
          RINGS.combination(rings_amount).each do |rings|
            selected_items = weapons + armor + rings

            player = {
              hp: 100,
              dmg: selected_items.sum { |i| i[:dmg] },
              armor: selected_items.sum { |i| i[:armor] }
            }

            boss = BOSS_STATS.dup

            while boss[:hp] > 0 && player[:hp] > 0
              dmg = player[:dmg] - boss[:armor]
              dmg = 1 if dmg < 1

              boss[:hp] -= dmg

              next if boss[:hp] <= 0

              dmg = boss[:dmg] - player[:armor]
              dmg = 1 if dmg < 1

              player[:hp] -= dmg
            end

            if player[:hp] > 0
              selected_items_cost = selected_items.sum { |i| i[:cost] }
              if selected_items_cost < min_gold
                min_gold = selected_items_cost
                min_items = selected_items
              end
            end
          end
        end
      end
    end
  end
end

p min_gold
p min_items

max_gold = 0
max_items = []

[1].each do |weapons_amount|
  [0, 1].each do |armor_amount|
    [0, 1, 2].each do |rings_amount|
      WEAPONS.combination(weapons_amount).each do |weapons|
        ARMOR.combination(armor_amount).each do |armor|
          RINGS.combination(rings_amount).each do |rings|
            selected_items = weapons + armor + rings

            player = {
              hp: 100,
              dmg: selected_items.sum { |i| i[:dmg] },
              armor: selected_items.sum { |i| i[:armor] }
            }

            boss = BOSS_STATS.dup

            while boss[:hp] > 0 && player[:hp] > 0
              dmg = player[:dmg] - boss[:armor]
              dmg = 1 if dmg < 1

              boss[:hp] -= dmg

              next if boss[:hp] <= 0

              dmg = boss[:dmg] - player[:armor]
              dmg = 1 if dmg < 1

              player[:hp] -= dmg
            end

            if player[:hp] < 0
              selected_items_cost = selected_items.sum { |i| i[:cost] }
              if selected_items_cost > max_gold
                max_gold = selected_items_cost
                max_items = selected_items
              end
            end
          end
        end
      end
    end
  end
end

p max_gold
p max_items
