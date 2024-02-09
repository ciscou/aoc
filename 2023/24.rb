INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

adj = Hash.new { |h, k| h[k] = Set.new }
nodes = Set.new

INPUT.each do |line|
  a, b = line.split(": ")
  b = b.split(" ")
  b.each { adj[a].add(_1) }
  b.each { adj[_1].add(a) }
  nodes.add(a)
  b.each { nodes.add(_1) }
end

def n_groups(nodes, adj)
  visited = Set.new
  res = [0]

  until nodes.empty?
    res << visited.size - res.last
    stack = []
    stack.push(nodes.first)
    until stack.empty?
      node = stack.pop

      nodes.delete(node)
      next if visited.include?(node)
      visited.add(node)

      adj[node].each { stack.push(_1) }
    end
  end

  res << visited.size - res.last

  res[2..]
end

intersections = []
adj.each do |k, v|
  v.each { intersections.push([k, _1]) }
end

intersections.combination(3) do |i1, i2, i3|
  [i1, i2, i3].each do |i|
    adj[i.first].delete(i.last)
    adj[i.last].delete(i.first)
  end
  g = n_groups(nodes.dup, adj)
  p [i1, i2, i3, g] if g.size > 1
  [i1, i2, i3].each do |i|
    adj[i.first].add(i.last)
    adj[i.last].add(i.first)
  end
end
