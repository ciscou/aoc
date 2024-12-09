INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

disk_map = INPUT.first.chars.map(&:to_i)

blocks = []
file_id = 0

disk_map.each_slice(2).each do |files, free|
  free ||= 0
  files.times do
    blocks << { file_id: file_id }
  end
  free.times do
    blocks << { empty: true }
  end
  file_id += 1
end

l = 0
r = blocks.length - 1

loop do
  l += 1 until blocks[l][:empty]
  r -= 1 while blocks[r][:empty]

  break unless l < r

  if blocks[l][:empty] && !blocks[r][:empty]
    blocks[l], blocks[r] = blocks[r], blocks[l]
  end

  l += 1
  r -= 1
end

# puts blocks.map { _1[:file_id] || "." }.join

part1 = blocks.each_with_index.sum do |block, i|
  next 0 if block[:empty]

  i * block[:file_id]
end
puts part1
