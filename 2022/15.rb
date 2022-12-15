require 'set'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

sensors = INPUT.map do |line|
  /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/ =~ line

  [$1, $2, $3, $4].map(&:to_i)
end

def merge_intervals(intervals)
  intervals.sort_by!(&:first)
  res = [intervals.first]

  intervals.each do |a, b|
    if res.last[1] >= a
      res.last[1] = b if b > res.last[1]
    else
      res.push([a, b])
    end
  end

  res
end

def intervals_at_row(sensors, row)
  intervals = []

  sensors.each do |sensor|
    sx, sy, bx, by = sensor

    dx = (bx - sx).abs
    dy = (by - sy).abs

    md = dx + dy

    oy = row - sy
    width = (md - oy.abs)
    if width > 0
      intervals << [sx-width, sx+width]
    end
  end

  merge_intervals(intervals)
end

row = 2_000_000
beacons = sensors.map { |_, _, x, y| [x, y] }.select { |_, y| y == row }.uniq
puts merge_intervals(intervals_at_row(sensors, row)).sum { |a, b| b - a + 1 } - beacons.size

max = 4_000_000
(0..max).each do |y|
  intervals_at_row(sensors, y).each_cons(2).each do |i1, i2|
    i1last = i1.last
    i2first = i2.first

    if i2first > i1last + 1 && i2first < max
      puts (i2first - 1) * 4_000_000 + y
    end
  end
end
