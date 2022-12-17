INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

jets = INPUT.first.chars
jet_idx = 0

rocks = [
  [
    "#  #### #",
  ],
  [
    "#   #   #",
    "#  ###  #",
    "#   #   #",
  ],
  [
    "#    #  #",
    "#    #  #",
    "#  ###  #",
  ],
  [
    "#  #    #",
    "#  #    #",
    "#  #    #",
    "#  #    #",
  ],
  [
    "#  ##   #",
    "#  ##   #",
  ],
]
rock_idx = 0

chamber = [
  "#########"
]

shifts = 0
seen = {}

loop do
  if chamber.length == 5000
    break if seen[[chamber, rock_idx % rocks.length, jet_idx % jets.length]]
    seen[[chamber.map(&:dup), rock_idx % rocks.length, jet_idx % jets.length]] = [rock_idx, jet_idx, shifts + chamber.length - 1]
  end

  rock = rocks[rock_idx % rocks.length].reverse.map.with_index do |row, index|
    row.chars.map.with_index { |char, col| { char: char, row: chamber.length + 3 + index, col: col } }
  end
  rock_idx += 1

  (3 + rock.length).times { chamber << "#       #" }

  resting = false
  until resting
    jet = jets[jet_idx % jets.length]
    jet_idx += 1

    dcol = jet == "<" ? -1 : 1
    can_move = true
    rock.each do |row|
      row.each_with_index do |cell, i|
        next unless i > 0 && i < 8
        next unless cell[:char] == "#"

        can_move = false unless cell[:col] + dcol > 0
        can_move = false unless cell[:col] + dcol < 8
        can_move = false if chamber[cell[:row]][cell[:col] + dcol] == "#"
      end
    end

    if can_move
      if dcol == -1
        rock.each do |row|
          row[1..-2].each_cons(2) do |c1, c2|
            c1[:char] = c2[:char]
          end
          row[-2][:char] = " "
        end
      else
        rock.each do |row|
          row[1..-2].reverse.each_cons(2) do |c1, c2|
            c1[:char] = c2[:char]
          end
          row[1][:char] = " "
        end
      end
    end

    rock.each do |row|
      row.each_with_index do |cell, i|
        resting = true if i > 0 && i < 8 && cell[:char] == "#" && chamber[cell[:row] - 1][cell[:col]] == "#"
        cell[:row] -= 1
      end
    end
  end

  rock.each do |row|
    row.each do |cell|
      cell[:row] += 1
    end
  end

  rock.each do |row|
    row.each do |col|
      chamber[col[:row]][col[:col]] = col[:char] if col[:char] == "#"
    end
  end

  chamber.pop while chamber.last == "#       #"
  while chamber.length > 5000
    chamber.shift
    shifts += 1
  end

  puts shifts + chamber.length - 1 if rock_idx == 2022
end

chamber_height = shifts + chamber.length - 1
rock_idx_was, jet_idx_was, chamber_height_was = seen[[chamber, rock_idx % rocks.length, jet_idx % jets.length]]

puts "was seen when rock_idx_was #{rock_idx_was}, jet_idx_was #{jet_idx_was}, and chamber_height_was #{chamber_height_was}"
puts "seen again now with rock_idx #{rock_idx}, jet_idx #{jet_idx}, and chamber_height #{chamber_height}"

loops, extra = (1_000_000_000_000 - rock_idx).divmod(rock_idx - rock_idx_was)
omg = loops * (chamber_height - chamber_height_was)

puts "we have to do #{loops} extra loops with extra #{extra} rocks adding #{omg} height"

extra.times do
  rock = rocks[rock_idx % rocks.length].reverse.map.with_index do |row, index|
    row.chars.map.with_index { |char, col| { char: char, row: chamber.length + 3 + index, col: col } }
  end
  rock_idx += 1

  (3 + rock.length).times { chamber << "#       #" }

  resting = false
  until resting
    jet = jets[jet_idx % jets.length]
    jet_idx += 1

    dcol = jet == "<" ? -1 : 1
    can_move = true
    rock.each do |row|
      row.each_with_index do |cell, i|
        next unless i > 0 && i < 8
        next unless cell[:char] == "#"

        can_move = false unless cell[:col] + dcol > 0
        can_move = false unless cell[:col] + dcol < 8
        can_move = false if chamber[cell[:row]][cell[:col] + dcol] == "#"
      end
    end

    if can_move
      if dcol == -1
        rock.each do |row|
          row[1..-2].each_cons(2) do |c1, c2|
            c1[:char] = c2[:char]
          end
          row[-2][:char] = " "
        end
      else
        rock.each do |row|
          row[1..-2].reverse.each_cons(2) do |c1, c2|
            c1[:char] = c2[:char]
          end
          row[1][:char] = " "
        end
      end
    end

    rock.each do |row|
      row.each_with_index do |cell, i|
        resting = true if i > 0 && i < 8 && cell[:char] == "#" && chamber[cell[:row] - 1][cell[:col]] == "#"
        cell[:row] -= 1
      end
    end
  end

  rock.each do |row|
    row.each do |cell|
      cell[:row] += 1
    end
  end

  rock.each do |row|
    row.each do |col|
      chamber[col[:row]][col[:col]] = col[:char] if col[:char] == "#"
    end
  end

  chamber.pop while chamber.last == "#       #"
  while chamber.length > 5000
    chamber.shift
    shifts += 1
  end
end

puts shifts + chamber.length - 1 + omg
