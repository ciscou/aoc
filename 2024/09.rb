INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def read_disk_map
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

  blocks
end

def checksum(blocks)
  blocks.each_with_index.sum do |block, i|
    next 0 if block[:empty]

    i * block[:file_id]
  end
end

def part1
  blocks = read_disk_map

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

  checksum(blocks)
end

def part2
  blocks = read_disk_map

  empty_space = []
  files = []
  offset = 0

  blocks.chunk(&:itself).each do |metadata, chunk|
    empty_space[offset] = { size: chunk.length } if metadata[:empty]
    files[offset] = { offset: offset, size: chunk.length, file_id: metadata[:file_id] } if metadata[:file_id]

    offset += chunk.length
  end

  files.reverse.each do |file|
    next if file.nil?

    empty_offset = empty_space.index do |empty_block|
      next if empty_block.nil?

      empty_block[:size] >= file[:size]
    end

    if empty_offset && empty_offset < file[:offset]
      file[:size].times do |i|
        blocks[empty_offset + i] = blocks[file[:offset] + i]
        blocks[file[:offset] + i] = { empty: true }
      end

      extra_empty_space = empty_space[empty_offset][:size] - file[:size]
      if extra_empty_space > 0
        empty_space[empty_offset + file[:size]] = { size: extra_empty_space }
      end

      empty_space[empty_offset] = nil
    end
  end

  checksum(blocks)
end

puts part1
puts part2
