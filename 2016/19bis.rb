100.times do |input|
  next if input == 0

  elves = input.times.map { |i| [i+1, 1] }
  turn  = 0

  while elves.size > 1
    turn %= elves.size

    elve = elves[turn]
    left = elves[(turn + elves.length / 2) % elves.length]

    # puts "elve #{elve.first} steals #{} #{left.first}'s #{left.last} presents"

    elve[1] += left[1]
    left[1] = 0

    turn += 1 unless elve.first > left.first

    elves.select! { |e| e.last > 0 }
  end

  p [input, elves.first.first, input == elves.first.first ? "###############" : ""]
end

input = 3004953

candidates = [1]
power_of_3 = 1

while candidates.last <= input
  power_of_3 *= 3
  candidates << power_of_3
end

candidate = candidates[-2]
extra = 0
offset = 1
(input - candidate).times do
  extra += offset
  offset = 2 if extra == candidate
end

puts extra
