require 'set'

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

sensors = INPUT.map do |line|
  /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/ =~ line

  [$1, $2, $3, $4].map(&:to_i)
end

grid = Hash.new { |h, k| h[k] = {} }

sensors.each do |sensor|
  sx, sy, bx, by = sensor

  dx = (bx - sx).abs
  dy = (by - sy).abs

  md = dx + dy

  oy = 2_000_000 - sy
  width = (md - oy.abs)
  (-width..width).each do |ox|
    x, y = sx + ox, sy + oy
    grid[y][x] = true
  end
end

beacons = sensors.map { |_, _, x, y| [x, y] }.select { |_, y| y == 2_000_000 }.uniq
puts grid[2_000_000].size - beacons.size
