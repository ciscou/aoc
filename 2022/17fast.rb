INPUT = File.readlines('17.txt', chomp: true)

class Aoc202217
  LEFT_OFFSET = 2
  BOTTOM_OFFSET = 3
  CHAMBER_WIDTH = 7
  CHAMBER_WIDTH_POWER_OF_TWO = 2 ** (CHAMBER_WIDTH - 1)

  ROCKS = [
    [
      0b0011110,
    ],
    [
      0b0001000,
      0b0011100,
      0b0001000,
    ],
    [
      0b0000100,
      0b0000100,
      0b0011100,
    ],
    [
      0b0010000,
      0b0010000,
      0b0010000,
      0b0010000,
    ],
    [
      0b0011000,
      0b0011000,
    ],
  ].map(&:reverse)

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
    BOTTOM_OFFSET.times { @chamber << 0 }

    rock = ROCKS[@rock_idx % ROCKS.length].map.with_index do |n, row|
      { n: n, row: @chamber.length + row }
    end
    @rock_idx += 1

    rock.length.times { @chamber << 0 }

    loop do
      jet_push(rock)
      break unless fall(rock)
    end

    rock.each do |cell|
      @chamber[cell[:row]] |= cell[:n]
    end

    @chamber.pop while @chamber.last == 0
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
      return false if dcol ==  1 && cell[:n].odd?
      return false if dcol == -1 && cell[:n] >= CHAMBER_WIDTH_POWER_OF_TWO

      cell[:next_n] = dcol == 1 ? cell[:n] >> 1 : cell[:n] << 1

      return false if @chamber[cell[:row]] & cell[:next_n] > 0
    end

    rock.each { |cell| cell[:n] = cell[:next_n] }

    true
  end

  def fall(rock)
    rock.each do |cell|
      row = cell[:row] - 1

      return false if row < 0
      return false if @chamber[row] & cell[:n] > 0
    end

    rock.each { |cell| cell[:row] -= 1 }

    true
  end
end

Aoc202217.new.solve
