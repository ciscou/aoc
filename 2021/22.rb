INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

reboot_steps = INPUT.map do |line|
  action, ranges = line.split(" ")

  {
    action: action,
    range: ranges.split(",").map do |range|
      range.split("=").last
    end.map do |s|
      s.split("..").map(&:to_i)
    end
  }
end

cubies = {}

reboot_steps.each do |step|
  range_x, range_y, range_z = step[:range]
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
