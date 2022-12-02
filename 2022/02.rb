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

def calculate_score(rounds)
  rounds.sum do |opponent, player|
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
end

def read_rounds(part:)
  INPUT.map do |line|
    opponent, player = line.split(" ")

    opponent_play = OPPONENT_PLAY[opponent]
    player_play = calculate_player_play(opponent_play, player, part)

    [
      opponent_play,
      player_play,
    ]
  end
end

def calculate_player_play(opponent_play, player, part)
  if part == 2
    case player
    when "X" then WINS[opponent_play]
    when "Y" then opponent_play
    when "Z" then LOSES[opponent_play]
    end
  else
    PLAYER_PLAY[player]
  end
end

rounds = read_rounds(part: 1)
puts calculate_score(rounds)

rounds = read_rounds(part: 2)
puts calculate_score(rounds)
