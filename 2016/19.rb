input = "3004953"
# input = "5"

elves = input.to_i.times.map { |i| [i+1, 1] }
turn  = 0

while elves.size > 1
  puts elves.size

  elve = elves[turn]
  left = elves.slice!((turn + elves.length / 2) % elves.length)

  # puts "elve #{elve.first} steals #{} #{left.first}'s #{left.last} presents"

  elve[1] += left[1]
  left[1] = 0

  turn += 1
  turn %= elves.size + 1
end

p elves
