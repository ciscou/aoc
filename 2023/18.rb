INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

minrow, mincol, maxrow, maxcol = Float::INFINITY, Float::INFINITY, -Float::INFINITY, -Float::INFINITY
row, col = 0, 0

rows = Hash.new { |h, k| h[k] = [] }

INPUT.each do |line|
  dir, steps, _color = line.split
  steps = steps.to_i

  case dir
  when "U"
    steps.times do
      row -= 1
      rows[row] << (col..col)
    end
  when "D"
    steps.times do
      row += 1
      rows[row] << (col..col)
    end
  when "L"
    rows[row] << ((col - steps)..col)
    col -= steps
  when "R"
    rows[row] << (col..(col + steps))
    col += steps
  else
    raise "invalid dir #{dir.inspect}"
  end

  minrow = [minrow, row].min
  mincol = [mincol, col].min
  maxrow = [maxrow, row].max
  maxcol = [maxcol, col].max
end

(minrow..maxrow).each do |row|
  (mincol..maxcol).each do |col|
    if rows[row].any? { _1.include?(col) }
      print "#"
    else
      print "."
    end
  end
  puts
end
