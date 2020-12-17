def two_adjacent?(s)
  slices = []
  last   = nil

  s.chars.each do |c|
    if c == last
      slices.last << c
    else
      slices.push(c.dup)
      last = c
    end
  end

  slices.any? { |s| s.length == 2 }
end

def no_decrease?(s)
  s.chars.each_cons(2).none? { |a, b| a > b }
end

valid = (240298..784956).select do |i|
  s = i.to_s

  res = two_adjacent?(s) && no_decrease?(s)

  p i if res

  res
end

puts valid.size
