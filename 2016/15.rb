discs = [
  [ 5,  2],
  [13,  7],
  [17, 10],
  [ 3,  2],
  [19,  9],
  [ 7,  0],
  [11,  0]
# [5, 4],
# [2, 1]
]

wait = 0
done = false

until done
  done = discs.each_with_index.all? do |disc, i|
    positions, position = disc
    (position + i + 1) % positions == 0
  end

  break if done

  discs.map! do |positions, position|
    position += 1
    position %= positions
    [positions, position]
  end

  wait += 1
end

puts wait
