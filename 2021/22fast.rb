INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

reboot_steps = INPUT.map do |line|
  action, ranges = line.split(" ")

  {
    action: action,
    ranges: ranges.split(",").map do |range|
      range.split("=").last
    end.map do |s|
      s.split("..").map(&:to_i)
    end
  }
end

cubies = {}

reboot_steps.each do |step|
  range_x, range_y, range_z = step[:ranges]
  action = step[:action]

  ([-50, range_x.first].max..[50, range_x.last].min).each do |x|
    ([-50, range_y.first].max..[50, range_y.last].min).each do |y|
      ([-50, range_z.first].max..[50, range_z.last].min).each do |z|
        if action == "on"
          cubies[[x, y, z]] = true
        else
          cubies.delete([x, y, z])
        end
      end
    end
  end
end

puts cubies.size

# part 2 corner compression highly inspired by https://www.youtube.com/watch?v=YKpViLcTp64

XS = []
YS = []
ZS = []

reboot_steps.each do |step|
  range_x, range_y, range_z = step[:ranges]

  XS << range_x.first << range_x.last + 1
  YS << range_y.first << range_y.last + 1
  ZS << range_z.first << range_z.last + 1
end

XS.sort!.uniq!
YS.sort!.uniq!
ZS.sort!.uniq!

matrix = Hash.new(false)

reboot_steps.each do |step|
  range_x, range_y, range_z = step[:ranges]
  action = step[:action]

  x1 = XS.bsearch_index { |x| x >= range_x.first }
  x2 = XS.bsearch_index { |x| x >= range_x.last + 1 }
  y1 = YS.bsearch_index { |y| y >= range_y.first }
  y2 = YS.bsearch_index { |y| y >= range_y.last + 1 }
  z1 = ZS.bsearch_index { |z| z >= range_z.first }
  z2 = ZS.bsearch_index { |z| z >= range_z.last + 1 }

  (x1...x2).each do |x|
    (y1...y2).each do |y|
      (z1...z2).each do |z|
        matrix[[x, y, z]] = action == "on"
      end
    end
  end
end

sum = 0

XS.length.times do |x|
  YS.length.times do |y|
    ZS.length.times do |z|
      if matrix[[x, y, z]]
        sum += (XS[x + 1] - XS[x]) * (YS[y + 1] - YS[y]) * (ZS[z + 1] - ZS[z])
      end
    end
  end
end

puts sum
