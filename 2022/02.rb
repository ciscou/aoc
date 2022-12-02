INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

OPPONENT_PLAY = { "A" => :rock, "B" => :paper, "C" => :scissors }
PLAYER_PLAY   = { "X" => :rock, "Y" => :paper, "Z" => :scissors }

PLAY_BONUS = { rock: 1, paper: 2, scissors: 3 }

OUTCOME_BONUS = { loss: 0, draw: 3, win: 6 }

WINS = {
      rock: :scissors,
  scissors: :paper,
     paper: :rock,
}

LOSES = WINS.invert

rounds = INPUT.map do |line|
  opponent, player = line.split(" ")

  [
    OPPONENT_PLAY[opponent],
    PLAYER_PLAY[player],
  ]
end

score = rounds.sum do |opponent, player|
  outcome_bonus = if opponent == player
                    3
                  elsif WINS[opponent] == player
                    0
                  else
                    6
                  end

  play_bonus = PLAY_BONUS[player]

  play_bonus + outcome_bonus
end

puts score

rounds = INPUT.map do |line|
  opponent, outcome = line.split(" ")

  [
    OPPONENT_PLAY[opponent],
    case outcome
    when "X" then WINS[OPPONENT_PLAY[opponent]]
    when "Y" then OPPONENT_PLAY[opponent]
    when "Z" then LOSES[OPPONENT_PLAY[opponent]]
    end,
  ]
end

score = rounds.sum do |opponent, player|
  outcome_bonus = if opponent == player
                    3
                  elsif WINS[opponent] == player
                    0
                  else
                    6
                  end

  play_bonus = PLAY_BONUS[player]

  play_bonus + outcome_bonus
end

puts score
