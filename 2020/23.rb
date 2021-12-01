input = 925176834

def perform_moves(input, moves_count, cups_count)
  cups = input.to_s.chars.map(&:to_i).map { |label| { label: label } }
  ((cups.length + 1)..cups_count).each { |label| cups << { label: label } }
  cups.each_cons(2) { |a, b| a[:next] = b }
  cups.each_cons(2) { |a, b| b[:prev] = a }
  cups.first[:prev] = cups.last
  cups.last[:next] = cups.first
  current = cups.first

  cups_by_label = cups.group_by { |cup| cup[:label] }

  moves_count.times do
    picks = []
    picks << current[:next]
    picks << picks.last[:next]
    picks << picks.last[:next]

    current[:next] = picks.last[:next]
    picks.last[:next][:prev] = current

    destination = current[:label] - 1
    destination = cups_count if destination < 1
    while picks.map { |pick| pick[:label] }.include?(destination)
      destination -= 1
      destination = cups_count if destination < 1
    end
    destination = cups_by_label[destination].first

    destination[:next][:prev] = picks.last
    picks.last[:next] = destination[:next]
    destination[:next] = picks.first
    picks.first[:prev] = destination

    current = current[:next]
  end

  cups_by_label
end

cups_by_label_1 = perform_moves(input, 100, 9)
part1 = []
current = cups_by_label_1[1].first
9.times do
  part1 << current
  current = current[:next]
end
puts part1[1..-1].map { |cup| cup[:label] }.join("")

cups_by_label_2 = perform_moves(input, 10_000_000, 1_000_000)
part2 = []
current = cups_by_label_2[1].first
3.times do
  part2 << current
  current = current[:next]
end
puts part2[1][:label] * part2[2][:label]
