planets = {}

while s = gets
  s.chomp!

  name1, name2 = s.split(")")

  planets[name1] ||= { name: name1 }
  planets[name2] ||= { name: name2 }

  planets[name2][:parent] = planets[name1]
end

you = planets["YOU"]
parents_you = []
parents_you << you while you = you[:parent]

san = planets["SAN"]
parents_san = []
parents_san << san while san = san[:parent]

res = 0

you = planets["YOU"][:parent]
until parents_san.include?(you)
  res += 1
  you = you[:parent]
end

san = planets["SAN"][:parent]
until parents_you.include?(san)
  res += 1
  san = san[:parent]
end

puts res
