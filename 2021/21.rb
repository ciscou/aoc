INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class DeterministicDie
  def initialize
    @next = 1
    @rolls = 0
  end

  attr_reader :rolls

  def roll
    res = @next
    @next += 1
    @next = 1 if @next > 100

    @rolls += 1

    res
  end
end

class PracticeGame
  def initialize
    @p1 = { id: 1, pos: INPUT[0].split(": ").last.to_i - 1, score: 0 }
    @p2 = { id: 2, pos: INPUT[1].split(": ").last.to_i - 1, score: 0 }

    @die = DeterministicDie.new
  end

  def play
    pcurr = @p1

    while [@p1, @p2].all? { |p| p[:score] < 1_000 } do
      pcurr[:pos] += 3.times.sum { @die.roll }
      pcurr[:pos] %= 10

      pcurr[:score] += pcurr[:pos] + 1

      pcurr = pcurr[:id] == 1 ? @p2 : @p1
    end
  end

  def outcome
    [@p1[:score], @p2[:score]].min * @die.rolls
  end
end

practice_game = PracticeGame.new
practice_game.play
puts practice_game.outcome

class RealGame
  def initialize
    @p1 =  { id: 1, pos: INPUT[0].split(": ").last.to_i - 1, score: 0 }
    @p2 =  { id: 2, pos: INPUT[1].split(": ").last.to_i - 1, score: 0 }
  end

  attr_reader :wins

  def play
    @wins_cache = {}
    @wins = do_play(@p1, @p2)
  end

  def do_play(p1, p2)
    cache_key = [p1[:id], p1[:pos], p1[:score], p2[:id], p2[:pos], p2[:score]]
    if cached_wins = @wins_cache[cache_key]
      return cached_wins
    end

    if [p1, p2].all? { |p| p[:score] < 21 }
      wins = {}

      (1..3).each do |roll1|
        (1..3).each do |roll2|
          (1..3).each do |roll3|
            pcurr = { id: p1[:id], pos: p1[:pos], score: p1[:score] }

            pcurr[:pos] += roll1 + roll2 + roll3
            pcurr[:pos] %= 10

            pcurr[:score] += pcurr[:pos] + 1

            wins.update(do_play(p2, pcurr)) { |k, v1, v2| v1 + v2 }
          end
        end
      end

      @wins_cache[cache_key] = wins
    else
      winner = [p1, p2].max_by { |p| p[:score] }

      @wins_cache[cache_key] = { winner[:id] => 1 }
    end
  end
end

real_game = RealGame.new
real_game.play
puts real_game.wins.values.max
