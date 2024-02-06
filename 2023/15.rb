INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def the_hash(s)
  s.chars.inject(0) do |current_value, char|
    ((current_value + char.ord) * 17) % 256
  end
end

part1 = INPUT.first.split(",").sum do |seq|
  the_hash(seq)
end

puts part1

boxes = 256.times.map { [] }

INPUT.first.split(",").each do |seq|
  if seq.include?("=")
    label, focal_length = seq.split("=")
    focal_length = focal_length.to_i
    box = boxes[the_hash(label)]
    lens = box.detect { |l, _| label == l }
    if lens
      lens[1] = focal_length
    else
      box.append([label, focal_length])
    end
  elsif seq.include?("-")
    label, _ = seq.split("-")
    box = boxes[the_hash(label)]
    box.delete_if { |l, _| label == l }
  else
    raise "invalid seq #{seq.inspect}"
  end
end

part2 = 0

boxes.each_with_index do |box, i|
  box.each_with_index do |lens, j|
    part2 += (i + 1) * (j + 1) * lens[1]
  end
end

puts part2
