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
