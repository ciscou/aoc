def fx(vx, n)
  # drag_for = n
  # drag_for = vx + 62 if vx < n
  # drag = triangular_number(drag_for)

  # vx * n - drag

  # drag = triangular_number(n)
  # drag -= triangular_number(n - vx) if(n > vx)

  # return vx * n - drag

  vxwas = vx

  x = 0
  dragged = 0
  n.times do
    x += vx

    if vx > 0
      vx -= 1
      dragged += dragged + 1
    end
  end

  x
end

def fy(vy, n)
  gravity = triangular_number(n - 1) # TODO -1?
  vy * n - gravity

  # y = 0
  # n.times do
  #   y += vy
  #   vy -= 1
  # end
  # y
end

def triangular_number(n)
  n * (n + 1) / 2
end

target = {
  x: { min: 248, max: 285 },
  y: { min: -85, max: -56 },
}

part1 = -Float::INFINITY
part2 = 0

(0..285).each do |vx|
  (-85..85).each do |vy|
    maxy = -Float::INFINITY
    overshot = false
    hit = false
    n = 0

    until overshot || hit
      n += 1

      x = fx(vx, n)
      y = fy(vy, n)

      maxy = y if y > maxy

      if x > target[:x][:max] || y < target[:y][:min]
        overshot = true
      elsif target[:x][:min] <= x && x <= target[:x][:max] && target[:y][:min] <= y && y <= target[:y][:max]
        part1 = maxy if maxy > part1
        part2 += 1

        hit = true
      end
    end
  end
end

puts part1
puts part2
