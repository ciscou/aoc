def turn(player, boss, shield, poison, recharge, spell)
  puts "player turn"
  p player
  p boss

  puts "shield" if shield > 1
  puts "poison" if poison > 1
  puts "recharge" if recharge > 1

  puts "player cast #{spell}"

  boss[:hp] -= 3 if poison > 0
  player[:mana] += 101 if recharge > 0
  extra_armor = shield > 1 ? 7 : 0

  shield -= 1
  poison -= 1
  recharge -= 1

  case spell
  when "magic_missile"
    player[:mana] -= 53
    boss[:hp] -= 4
  when "drain"
    player[:mana] -= 73
    boss[:hp] -= 2
    player[:hp] += 2
  when "shield"
    player[:mana] -= 113
    shield = 6
  when "poison"
    player[:mana] -= 173
    poison = 6
  when "recharge"
    player[:mana] -= 229
    recharge = 5
  else
    raise "unknown spell #{spell.inspect}"
  end

  puts
  puts
  puts "boss turn"
  p player
  p boss

  puts "shield" if shield > 1
  puts "poison" if poison > 1
  puts "recharge" if recharge > 1

  extra_armor = shield > 1 ? 7 : 0
  boss[:hp] -= 3 if poison > 0
  player[:mana] += 101 if recharge > 0

  if boss[:hp] > 0
    puts "boss attack"

    dmg = boss[:dmg] - extra_armor
    dmg = 1 if dmg < 1

    player[:hp] -= dmg
  end
end

# player = { hp: 10, mana: 250 }
# boss = { hp: 13, dmg: 8 }

# turn(player, boss, 0, 0, 0, "poison")
# p player
# p boss

# turn(player, boss, 0, 5, 0, "magic_missile")
# p player
# p boss

player = { hp: 10, mana: 250 }
boss = { hp: 14, dmg: 8 }

turn(player, boss, 0, 0, 0, "recharge")
puts
puts

turn(player, boss, 0, 0, 4, "shield")
puts
puts

turn(player, boss, 5, 0, 2, "drain")
puts
puts

turn(player, boss, 3, 0, 0, "poison")
puts
puts

turn(player, boss, 1, 5, 0, "magic_missile")
puts
puts
