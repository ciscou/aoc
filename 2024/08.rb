INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

H = INPUT.length
W = INPUT.first.length

antennas = Hash.new { |h, k| h[k] = [] }

INPUT.each_with_index do |row, r|
  row.chars.each_with_index do |cell, c|
    next if cell == "."

    antennas[cell] << [r, c]
  end
end

def antinodes_for(antennas, part2:)
  antinodes = Set.new

  antennas.each do |freq, freq_antennas|
    freq_antennas.combination(2).each do |a1, a2|
      dr = a2[0] - a1[0]
      dc = a2[1] - a1[1]

      range = part2 ? (0..100) : [1]
      range.each do |i|
        antinodes.add [a2[0] + dr * i, a2[1] + dc * i]
        antinodes.add [a1[0] - dr * i, a1[1] - dc * i]
      end
    end
  end

  antinodes.select! do |a|
    next false if a[0] < 0
    next false if a[1] < 0
    next false unless a[0] < H
    next false unless a[1] < W

    true
  end

  antinodes
end

part1 = antinodes_for(antennas, part2: false).size
puts part1

part2 = antinodes_for(antennas, part2: true).size
puts part2
