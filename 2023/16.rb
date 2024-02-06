INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def split(beam, splitter)
  row, col, dir = beam

  case splitter
  when "|"
    case dir
    when :left, :right
      [
        [row, col, :up],
        [row, col, :down],
      ]
    when :up, :down
      [
        [row, col, dir]
      ]
    else
      raise "invalid dir #{dir.inspect}"
    end
  when "-"
    case dir
    when :left, :right
      [
        [row, col, dir]
      ]
    when :up, :down
      [
        [row, col, :left],
        [row, col, :right],
      ]
    else
      raise "invalid dir #{dir.inspect}"
    end
  else
    raise "invalid splitter #{splitter.inspect}"
  end
end

def reflect(beam, mirror)
  row, col, dir = beam

  case mirror
  when "/"
    case dir
    when :left
      [row, col, :down]
    when :right
      [row, col, :up]
    when :up
      [row, col, :right]
    when :down
      [row, col, :left]
    else
      raise "invalid dir #{dir.inspect}"
    end
  when "\\"
    case dir
    when :left
      [row, col, :up]
    when :right
      [row, col, :down]
    when :up
      [row, col, :left]
    when :down
      [row, col, :right]
    else
      raise "invalid dir #{dir.inspect}"
    end
  else
    raise "invalid mirror #{mirror.inspect}"
  end
end

def f(initial_beam)
  beams = [initial_beam]
  grid = {}

  INPUT.each_with_index do |line, row|
    line.chars.each_with_index do |char, col|
      grid[[row, col]] = [char, []]
    end
  end

  loop do
    next_beams = []

    beams.each do |beam|
      row, col, dir = beam

      case dir
      when :up
        row -= 1
      when :down
        row += 1
      when :left
        col -= 1
      when :right
        col += 1
      else
        raise "invalid dir #{dir.inspect}"
      end

      cell = grid[[row, col]]

      next unless cell

      case cell[0]
      when "."
        next_beams << [row, col, dir]
      when "/", "\\"
        reflected = reflect([row, col, dir], cell[0])
        next_beams << reflected
      when "-", "|"
        splitted = split([row, col, dir], cell[0])
        next_beams += splitted
      else
        raise "invalid cell #{cell.inspect}"
      end
    end

    some_energized = false

    next_beams.each do |next_beam|
      row, col, dir = next_beam

      cell = grid[[row, col]]

      next unless cell

      if !cell[1].include?(next_beam[2])
        some_energized = true
        cell[1] << next_beam[2]
      end
    end

    break unless some_energized

    beams = next_beams.uniq
  end

  grid.values.count { _1.last.length > 0 }
end

part1 = f([0, -1, :right])
puts part1

part2 = 0
110.times do |i|
  part2 = [part2, f([i, -1, :right])].max
  part2 = [part2, f([i, 110, :left])].max
  part2 = [part2, f([-1, i, :down])].max
  part2 = [part2, f([110, i, :up])].max
end
puts part2
