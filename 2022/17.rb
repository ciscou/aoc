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

chamber = [
  "#########"
]

2022.times do |rock_idx|
  rock = rocks[rock_idx % rocks.length].reverse.map.with_index do |row, index|
    row.chars.map.with_index { |char, col| { char: char, row: chamber.length + 3 + index, col: col } }
  end

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
end

# chamber.reverse_each do |row|
#   puts row.chars.join(" ")
# end

puts chamber.length - 1
