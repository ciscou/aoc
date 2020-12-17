input = "478 players; last marble is worth 71240 points"

number_of_players = input.split(" ").first.to_i
last_marble = input.split(" ")[-2].to_i
last_marble *= 100

current_marble = { val: 0 }
current_marble[:prev] = current_marble
current_marble[:next] = current_marble

players = number_of_players.times.map { 0 }
player = 0

(1..last_marble).each do |marble|
  if marble % 23 == 0
    players[player] += marble
    7.times { current_marble = current_marble[:prev] }
    players[player] += current_marble[:val]
    current_marble[:prev][:next] = current_marble[:next]
    current_marble[:next][:prev] = current_marble[:prev]
    current_marble = current_marble[:next]
  else
    current_marble = current_marble[:next]
    new_marble = { val: marble, prev: current_marble, next: current_marble[:next] }
    current_marble[:next] = new_marble
    new_marble[:next][:prev] = new_marble
    current_marble = new_marble
  end

  player += 1
  player %= players.length
end

puts players.max
