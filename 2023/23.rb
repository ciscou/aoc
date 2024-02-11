INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = {}
graph = {}

INPUT.each_with_index do |line, row|
  line.chars.each_with_index do |char, col|
    char = "." if %w[< > ^ v].include?(char)
    grid[[row, col]] = char
  end
end

rows = grid.keys.map(&:first).max + 1
cols = grid.keys.map(&:last).max + 1

grid.each do |k, v|
  r, c = k
  next unless v == "."
  hexits, vexits = 0, 0
  hexits += 1 if grid[[r+1,c]] == "."
  hexits += 1 if grid[[r-1,c]] == "."
  vexits += 1 if grid[[r,c+1]] == "."
  vexits += 1 if grid[[r,c-1]] == "."
  next unless [r, c] == [0, 1] || [r, c] == [rows - 1, cols - 2] || (hexits * vexits > 0)
  graph[k] = {}
end

graph.each do |k, v|
  row, col = k

  r = row + 1
  loop do
    break unless grid[[r, col]] == "."
    if graph[[r, col]]
      v[:d] = [r, col]
      break
    end
    r += 1
  end

  r = row - 1
  loop do
    break unless grid[[r, col]] == "."
    if graph[[r, col]]
      v[:u] = [r, col]
      break
    end
    r -= 1
  end

  c = col + 1
  loop do
    break unless grid[[row, c]] == "."
    if graph[[row, c]]
      v[:r] = [row, c]
      break
    end
    c += 1
  end

  c = col - 1
  loop do
    break unless grid[[row, c]] == "."
    if graph[[row, c]]
      v[:l] = [row, c]
      break
    end
    c -= 1
  end
end

def dfs(graph, rows, cols, row, col, visited, length)
  res = 0

  if row == rows-1 && col==cols-2
    return length
  end

  return if visited[[row, col]]
  # return unless graph[[row, col]]

  visited[[row, col]] = true

  node = graph[[row, col]]
  %i[u d l r].each do |dir|
    next_node = node[dir]
    next unless next_node
    next if visited[next_node]

    dist = (next_node.first - row).abs + (next_node.last - col).abs
    res = [res, dfs(graph, rows, cols, next_node.first, next_node.last, visited, length + dist)].max
  end

  visited.delete([row, col])

  res
end

puts dfs(graph, rows, cols, 0, 1, {}, 0)

exit
rows.times do |r|
  cols.times do |c|
    if graph[[r, c]]
      print "x"
    elsif grid[[r, c]] == "."
      print " "
    else
      print grid[[r, c]]
    end
  end
  puts
end
