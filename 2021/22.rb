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

class Prism
  def initialize(ranges)
    @xmin, @xmax = ranges[0]
    @ymin, @ymax = ranges[1]
    @zmin, @zmax = ranges[2]
  end

  attr_reader :xmin, :xmax, :ymin, :ymax, :zmin, :zmax

  def volume
    (@xmax - @xmin + 1) *
    (@ymax - @ymin + 1) *
    (@zmax - @zmin + 1)
  end

  def remove(hole)
    res = [self]

    x_split_points = [[@xmin, @xmax]]

    if @xmin <= hole.xmin && hole.xmax <= @xmax
      x_split_points = [[@xmin, hole.xmin - 1], [hole.xmin, hole.xmax], [hole.xmax + 1, @xmax]]
    elsif hole.xmin <= @xmin && @xmin <= hole.xmax && hole.xmax <= @xmax
      x_split_points = [[@xmin, hole.xmax], [hole.xmax + 1, @xmax]]
    elsif @xmin <= hole.xmin && hole.xmin <= @xmax && @xmax <= hole.xmax
      x_split_points = [[@xmin, hole.xmin - 1], [hole.xmin, @xmax]]
    end

    x_split_points.reject! { |a, b| a > b }

    res = x_split_points.flat_map do |x1, x2|
      res.map do |prism|
        Prism.new([[x1, x2], [prism.ymin, prism.ymax], [prism.zmin, prism.zmax]])
      end
    end

    y_split_points = [[@ymin, @ymax]]

    if @ymin <= hole.ymin && hole.ymax <= @ymax
      y_split_points = [[@ymin, hole.ymin - 1], [hole.ymin, hole.ymax], [hole.ymax + 1, @ymax]]
    elsif hole.ymin <= @ymin && @ymin <= hole.ymax && hole.ymax <= @ymax
      y_split_points = [[@ymin, hole.ymax], [hole.ymax + 1, @ymax]]
    elsif @ymin <= hole.ymin && hole.ymin <= @ymax && @ymax <= hole.ymax
      y_split_points = [[@ymin, hole.ymin - 1], [hole.ymin, @ymax]]
    end

    y_split_points.reject! { |a, b| a > b }

    res = y_split_points.flat_map do |y1, y2|
      res.map do |prism|
        Prism.new([[prism.xmin, prism.xmax], [y1, y2], [prism.zmin, prism.zmax]])
      end
    end

    z_split_points = [[@zmin, @zmax]]

    if @zmin <= hole.zmin && hole.zmax <= @zmax
      z_split_points = [[@zmin, hole.zmin - 1], [hole.zmin, hole.zmax], [hole.zmax + 1, @zmax]]
    elsif hole.zmin <= @zmin && @zmin <= hole.zmax && hole.zmax <= @zmax
      z_split_points = [[@zmin, hole.zmax], [hole.zmax + 1, @zmax]]
    elsif @zmin <= hole.zmin && hole.zmin <= @zmax && @zmax <= hole.zmax
      z_split_points = [[@zmin, hole.zmin - 1], [hole.zmin, @zmax]]
    end

    z_split_points.reject! { |a, b| a > b }

    res = z_split_points.flat_map do |z1, z2|
      res.map do |prism|
        Prism.new([[prism.xmin, prism.xmax], [prism.ymin, prism.ymax], [z1, z2]])
      end
    end

    res.reject do |prism|
      hole.xmin <= prism.xmin && prism.xmax <= hole.xmax &&
      hole.ymin <= prism.ymin && prism.ymax <= hole.ymax &&
      hole.zmin <= prism.zmin && prism.zmax <= hole.zmax
    end
  end
end

prisms = []

reboot_steps.each_with_index do |step, index|
  puts index
  puts prisms.size

  ranges = step[:ranges]
  action = step[:action]

  prism = Prism.new(ranges)

  prisms = prisms.flat_map { |p| p.remove(prism) }
  prisms << prism if action == "on"
end

puts prisms.sum(&:volume)
