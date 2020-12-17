input = <<EOS
Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds.
Blitzen can fly 13 km/s for 4 seconds, but then must rest for 49 seconds.
Rudolph can fly 20 km/s for 7 seconds, but then must rest for 132 seconds.
Cupid can fly 12 km/s for 4 seconds, but then must rest for 43 seconds.
Donner can fly 9 km/s for 5 seconds, but then must rest for 38 seconds.
Dasher can fly 10 km/s for 4 seconds, but then must rest for 37 seconds.
Comet can fly 3 km/s for 37 seconds, but then must rest for 76 seconds.
Prancer can fly 9 km/s for 12 seconds, but then must rest for 97 seconds.
Dancer can fly 37 km/s for 1 seconds, but then must rest for 36 seconds.
EOS

reindeer = []

input.lines.each do |line|
  line.chomp!

  case line
  when /^(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds.$/
    reindeer << { name: $1, speed: $2.to_i, moving: $3.to_i, resting: $4.to_i }
  else
    raise "cannot match #{line.inspect}"
  end
end

reindeer.each do |r|
  r[:status] = :moving
  r[:distance] = 0
  r[:elapsed] = 0
  r[:points] = 0
end

2503.times do
  reindeer.each do |r|
    r[:distance] += r[:speed] if r[:status] == :moving

    r[:elapsed] += 1

    if r[:elapsed] >= r[r[:status]]
      r[:status] = r[:status] == :moving ? :resting : :moving
      r[:elapsed] = 0
    end
  end

  max_distance = reindeer.map { |r| r[:distance] }.max

  reindeer.each do |r|
    r[:points] += 1 if r[:distance] == max_distance
  end
end

p reindeer.map { |r| r[:points] }.max
