INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = Hash.new(Float::INFINITY)

INPUT.each_with_index do |line, row|
  line.chars.each_with_index do |char, col|
    grid[[row, col]] = char.to_i
  end
end

rows = grid.keys.map(&:first).max + 1
cols = grid.keys.map(&:last).max + 1

initial_node_1 = {
  row: 0,
  col: 4,
  dir: :right,
  straight: 4,
  loss: grid[[0, 1]] + grid[[0, 2]] + grid[[0, 3]],
  path: [:right],
}

initial_node_2 = {
  row: 4,
  col: 0,
  dir: :down,
  straight: 4,
  loss: grid[[1, 0]] + grid[[2, 0]] + grid[[3, 0]],
  path: [:down],
}

stack = []
stack.push(initial_node_1)
stack.push(initial_node_2)

seen = Hash.new(Float::INFINITY)

part1 = Float::INFINITY

until stack.empty?
  node = stack.pop

  next if node[:straight] > 10
  next if node[:row] < 0
  next if node[:col] < 0
  next if node[:row] >= rows
  next if node[:col] >= cols

  dist = rows - node[:row] + cols - node[:col]
  next if node[:loss] + dist > part1

  if node[:row] == rows - 1 && node[:col] == cols - 1
    loss = node[:loss] + grid[[node[:row], node[:col]]]
    # puts "goal: #{loss}"
    if loss < part1
      part1 = loss
      # p part1
    end
  end

  next if seen[[node[:row], node[:col], node[:dir], node[:straight]]] <= node[:loss]
  seen[[node[:row], node[:col], node[:dir], node[:straight]]] = node[:loss]

  case node[:dir]
  when :up
    stack.push(
      row: node[:row] - 1,
      col: node[:col],
      dir: node[:dir],
      straight: node[:straight] + 1,
      loss: node[:loss] + grid[[node[:row], node[:col]]],
      path: node[:path] + [:up],
    )
    stack.push(
      row: node[:row],
      col: node[:col] - 4,
      dir: :left,
      straight: 4,
      loss: node[:loss] + grid[[node[:row], node[:col]]] + grid[[node[:row], node[:col]-1]] + grid[[node[:row], node[:col]-2]] + grid[[node[:row], node[:col]-3]],
      path: node[:path] + [:left],
    )
    stack.push(
      row: node[:row],
      col: node[:col] + 4,
      dir: :right,
      straight: 4,
      loss: node[:loss] + grid[[node[:row], node[:col]]] + grid[[node[:row], node[:col]+1]] + grid[[node[:row], node[:col]+2]] + grid[[node[:row], node[:col]+3]],
      path: node[:path] + [:right],
    )
  when :down
    stack.push(
      row: node[:row] + 1,
      col: node[:col],
      dir: node[:dir],
      straight: node[:straight] + 1,
      loss: node[:loss] + grid[[node[:row], node[:col]]],
      path: node[:path] + [:down],
    )
    stack.push(
      row: node[:row],
      col: node[:col] - 4,
      dir: :left,
      straight: 4,
      loss: node[:loss] + grid[[node[:row], node[:col]]] + grid[[node[:row], node[:col]-1]] + grid[[node[:row], node[:col]-2]] + grid[[node[:row], node[:col]-3]],
      path: node[:path] + [:left],
    )
    stack.push(
      row: node[:row],
      col: node[:col] + 4,
      dir: :right,
      straight: 4,
      loss: node[:loss] + grid[[node[:row], node[:col]]] + grid[[node[:row], node[:col]+1]] + grid[[node[:row], node[:col]+2]] + grid[[node[:row], node[:col]+3]],
      path: node[:path] + [:right],
    )
  when :left
    stack.push(
      row: node[:row],
      col: node[:col] - 1,
      dir: node[:dir],
      straight: node[:straight] + 1,
      loss: node[:loss] + grid[[node[:row], node[:col]]],
      path: node[:path] + [:left],
    )
    stack.push(
      row: node[:row] - 4,
      col: node[:col],
      dir: :up,
      straight: 4,
      loss: node[:loss] + grid[[node[:row], node[:col]]] + grid[[node[:row]-1, node[:col]]] + grid[[node[:row]-2, node[:col]]] + grid[[node[:row]-3, node[:col]]],
      path: node[:path] + [:up],
    )
    stack.push(
      row: node[:row] + 4,
      col: node[:col],
      dir: :down,
      straight: 4,
      loss: node[:loss] + grid[[node[:row], node[:col]]] + grid[[node[:row]+1, node[:col]]] + grid[[node[:row]+2, node[:col]]] + grid[[node[:row]+3, node[:col]]],
      path: node[:path] + [:down],
    )
  when :right
    stack.push(
      row: node[:row],
      col: node[:col] + 1,
      dir: node[:dir],
      straight: node[:straight] + 1,
      loss: node[:loss] + grid[[node[:row], node[:col]]],
      path: node[:path] + [:right],
    )
    stack.push(
      row: node[:row] - 4,
      col: node[:col],
      dir: :up,
      straight: 4,
      loss: node[:loss] + grid[[node[:row], node[:col]]] + grid[[node[:row]-1, node[:col]]] + grid[[node[:row]-2, node[:col]]] + grid[[node[:row]-3, node[:col]]],
      path: node[:path] + [:up],
    )
    stack.push(
      row: node[:row] + 4,
      col: node[:col],
      dir: :down,
      straight: 4,
      loss: node[:loss] + grid[[node[:row], node[:col]]] + grid[[node[:row]+1, node[:col]]] + grid[[node[:row]+2, node[:col]]] + grid[[node[:row]+3, node[:col]]],
      path: node[:path] + [:down],
    )
  else
    raise "invalid dir #{dir.inspect}"
  end
end

puts part1
