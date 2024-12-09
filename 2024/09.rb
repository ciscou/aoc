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

def part1_blocks
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

  blocks
end

def part2_blocks
  blocks = read_disk_map

  empty_space = []
  files = []
  offset = 0

  blocks.chunk(&:itself).each do |metadata, chunk|
    empty_space << { offset: offset, size: chunk.length } if metadata[:empty]
    files << { offset: offset, size: chunk.length, file_id: metadata[:file_id] } if metadata[:file_id]

    offset += chunk.length
  end

  files.reverse.each do |file|
    empty_block = empty_space.detect do |eb|
      break unless eb[:offset] < file[:offset]

      eb[:size] >= file[:size]
    end

    if empty_block
      file[:size].times do |i|
        blocks[empty_block[:offset] + i] = blocks[file[:offset] + i]
        blocks[file[:offset] + i] = { empty: true }
      end

      empty_block[:offset] += file[:size]
      empty_block[:size] -= file[:size]
    end
  end

  blocks
end

puts checksum(part1_blocks)
puts checksum(part2_blocks)
