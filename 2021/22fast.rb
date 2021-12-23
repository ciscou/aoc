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

XS.sort!
YS.sort!
ZS.sort!

matrix = Hash.new(false)

reboot_steps.each do |step|
  range_x, range_y, range_z = step[:ranges].map { |min, max| Range.new(min, max) }
  action = step[:action]

  XS.each do |x1|
    YS.each do |y1|
      ZS.each do |z1|
        matrix[[x1, y1, z1]] = action == "on" if range_x.include?(x1) && range_y.include?(y1) && range_z.include?(z1)
      end
    end
  end
end

sum = 0

XS.each_cons(2) do |x1, x2|
  YS.each_cons(2) do |y1, y2|
    ZS.each_cons(2) do |z1, z2|
      sum += (x2 - x1) * (y2 - y1) * (z2 - z1) if matrix[[x1, y1, z1]]
    end
  end
end

puts sum
