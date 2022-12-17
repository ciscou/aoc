INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Aoc202217
  LEFT_OFFSET = 2
  BOTTOM_OFFSET = 3
  CHAMBER_WIDTH = 7

  ROCKS = [
    [
      "####",
    ],
    [
      " # ",
      "###",
      " # ",
    ],
    [
      "  #",
      "  #",
      "###",
    ],
    [
      "#",
      "#",
      "#",
      "#",
    ],
    [
      "##",
      "##",
    ],
  ]

  TRUNCATE_CHAMBER = 1000

  JETS = INPUT.first.chars

  def initialize
    @jet_idx = 0
    @rock_idx = 0
    @shifts = 0
    @chamber = []
  end

  def solve
    seen = {}

    loop do
      if @chamber.length == TRUNCATE_CHAMBER
        break if seen[[@chamber, @rock_idx % ROCKS.length, @jet_idx % JETS.length]]
        seen[[@chamber, @rock_idx % ROCKS.length, @jet_idx % JETS.length]] = [@rock_idx, @shifts + @chamber.length]
      end

      simulation_step

      puts @shifts + @chamber.length if @rock_idx == 2022
    end

    chamber_height = @shifts + @chamber.length
    rock_idx_was, chamber_height_was = seen[[@chamber, @rock_idx % ROCKS.length, @jet_idx % JETS.length]]

    # this config was seen when rock_idx was `rock_idx_was` and chamber_height was `chamber_height_was`
    # it has been seen again now with rock_idx = `@rock_idx` and chamber_height = `chamber_height`

    loops, extra = (1_000_000_000_000 - @rock_idx).divmod(@rock_idx - rock_idx_was)
    omg = loops * (chamber_height - chamber_height_was)

    # we have to do `loops` complete loops with extra `extra` rocks, adding `omg` height

    extra.times do
      simulation_step
    end

    puts @shifts + @chamber.length + omg
  end

  private

  def simulation_step
    BOTTOM_OFFSET.times { @chamber << " " * CHAMBER_WIDTH }

    rock = ROCKS[@rock_idx % ROCKS.length].reverse.flat_map.with_index do |line, row|
      line.chars.map.with_index { |char, col| { char: char, row: @chamber.length + row, col: col + LEFT_OFFSET } }
    end
    @rock_idx += 1

    rock.length.times { @chamber << " " * CHAMBER_WIDTH }

    loop do
      jet_push(rock)
      break unless fall(rock)
    end

    rock.each do |cell|
      @chamber[cell[:row]][cell[:col]] = cell[:char] if cell[:char] == "#"
    end

    @chamber.pop while @chamber.last.strip.empty?
    while @chamber.length > TRUNCATE_CHAMBER
      @chamber.shift
      @shifts += 1
    end
  end

  def jet_push(rock)
    jet = JETS[@jet_idx % JETS.length]
    @jet_idx += 1

    dcol = jet == "<" ? -1 : 1
    rock.each do |cell|
      next unless cell[:char] == "#"

      col = cell[:col] + dcol

      return false unless (0...CHAMBER_WIDTH).include?(col)
      return false if @chamber[cell[:row]][col] == "#"
    end

    rock.each { |cell| cell[:col] += dcol }

    true
  end

  def fall(rock)
    rock.each do |cell|
      next unless cell[:char] == "#"

      row = cell[:row] - 1

      return false if row < 0
      return false if @chamber[row][cell[:col]] == "#"
    end

    rock.each { |cell| cell[:row] -= 1 }

    true
  end
end

Aoc202217.new.solve
