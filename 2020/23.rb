input = 925176834

cups = input.to_s.chars.map(&:to_i).map { |label| { label: label } }
cups.each_cons(2) { |a, b| a[:next] = b }
cups.each_cons(2) { |a, b| b[:prev] = a }
cups.first[:prev] = cups.last
cups.last[:next] = cups.first
current = cups.first

cups_by_label = cups.group_by { |cup| cup[:label] }

100.times do
  kks = []
  kk = current
  9.times do
    kks << kk
    kk = kk[:next]
  end
  puts kks.map { |cup| cup[:label] }.join(", ")

  picks = []
  picks << current[:next]
  picks << picks.last[:next]
  picks << picks.last[:next]
  puts picks.map { |cup| cup[:label] }.join(", ")

  current[:next] = picks.last[:next]
  picks.last[:next][:prev] = current

  destination = current[:label] - 1
  destination = 9 if destination < 1
  while picks.map { |pick| pick[:label] }.include?(destination)
    destination -= 1
    destination = 9 if destination < 1
  end
  puts "@@@#{destination.inspect}@@@"
  destination = cups_by_label[destination].first
  puts destination[:label]

  destination[:next][:prev] = picks.last
  picks.last[:next] = destination[:next]
  destination[:next] = picks.first
  picks.first[:prev] = destination

  current = current[:next]
end

kks = []
kk = cups_by_label[1].first
9.times do
  kks << kk
  kk = kk[:next]
end
puts kks.map { |cup| cup[:label] }.join("")
