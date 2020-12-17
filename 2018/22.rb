$depth = 8112
$target_x = 13
$target_y = 743

$geological_index_cache = {}
$geological_index_cache[[0, 0]] = 0
$geological_index_cache[[$target_x, $target_y]] = 0

def geological_index(pos)
  return $geological_index_cache[pos] if $geological_index_cache.key?(pos)

  x, y = pos
  $geological_index_cache[pos] = if y == 0
                                   x * 16807
                                 elsif x == 0
                                   y * 48271
                                 else
                                   erosion_level([x-1, y]) * erosion_level([x, y-1])
                                 end
end

def erosion_level(pos)
  (geological_index(pos) + $depth) % 20183
end

def type(pos)
  case erosion_level(pos) % 3
  when 0 then :rocky
  when 1 then :wet
  when 2 then :narrow
  else raise
  end
end

risk_level = 0

(0..$target_y).each do |y|
  (0..$target_x).each do |x|
    risk_level += erosion_level([x, y]) % 3
  end
end

puts risk_level
