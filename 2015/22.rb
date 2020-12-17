def turn(initial_player, initial_boss, initial_shield, initial_poison, initial_recharge, initial_mana_spent, spells)
  return if initial_mana_spent > 1400

  initial_player = initial_player.dup
  initial_player[:mana] += 101 if initial_recharge > 0

  available_spells = %w[magic_missile drain shield poison recharge]

  available_spells.delete("shield")   if initial_shield > 1
  available_spells.delete("poison")   if initial_poison > 1
  available_spells.delete("recharge") if initial_recharge > 1

  available_spells.delete("magic_missile") if initial_player[:mana] < 53
  available_spells.delete("drain")         if initial_player[:mana] < 73
  available_spells.delete("shield")        if initial_player[:mana] < 113
  available_spells.delete("poison")        if initial_player[:mana] < 173
  available_spells.delete("recharge")      if initial_player[:mana] < 229

  available_spells.each do |spell|
    player = initial_player.dup
    boss = initial_boss.dup

    player[:hp] -= 1
    return if player[:hp] < 1

    shield = initial_shield
    poison = initial_poison
    recharge = initial_recharge

    mana_spent = initial_mana_spent

    boss[:hp] -= 3 if poison > 0
    # player[:mana] += 101 if recharge > 0
    extra_armor = shield > 1 ? 7 : 0

    shield -= 1
    poison -= 1
    recharge -= 1

    case spell
    when "magic_missile"
      player[:mana] -= 53
      mana_spent += 53
      boss[:hp] -= 4
    when "drain"
      player[:mana] -= 73
      mana_spent += 73
      boss[:hp] -= 2
      player[:hp] += 2
    when "shield"
      player[:mana] -= 113
      mana_spent += 113
      shield = 6
    when "poison"
      player[:mana] -= 173
      mana_spent += 173
      poison = 6
    when "recharge"
      player[:mana] -= 229
      mana_spent += 229
      recharge = 5
    else
      raise "unknown spell #{spell.inspect}"
    end

    player[:hp] -= 1
    return if player[:hp] < 1

    extra_armor = shield > 1 ? 7 : 0
    boss[:hp] -= 3 if poison > 0
    player[:mana] += 101 if recharge > 0

    if boss[:hp] > 0
      dmg = boss[:dmg] - extra_armor
      dmg = 1 if dmg < 1

      player[:hp] -= dmg
    end

    if boss[:hp] < 0
      spells + [spell]
      puts "#{mana_spent} #{(spells + [spell]).inspect}"
    elsif player[:hp] < 0
      [nil]
    else
      turn(player, boss, shield-1, poison-1, recharge-1, mana_spent, spells + [spell])
    end
  end
end

player = { hp: 50, mana: 500 }
boss = { hp: 58, dmg: 9 }

puts "turn!"
turn(player, boss, 0, 0, 0, 0, [])
