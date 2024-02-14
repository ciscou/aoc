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

class Tarjan
  def initialize(nodes, adj)
    @nodes = nodes.to_a
    kk = Hash[@nodes.each_with_index.to_a]
    @adj = []
    @nodes.length.times { @adj << [] }
    adj.each do |k, v|
      v.each { @adj[kk[k]] << kk[_1] }
    end
    @visited = [false] * @nodes.length
    @tin = [-1] * @nodes.length
    @low = [-1] * @nodes.length
    @timer = 0
    @bridges = []
  end

  attr_reader :bridges

  def run!
    @nodes.each_with_index do |node, i|
      dfs(i) unless @visited[i]
    end
    @bridges.each(&:sort!)
    @bridges.sort!
    @bridges.uniq!
  end

  private

  def dfs(v, p=-1)
    @visited[v] = true
    @tin[v] = @low[v] = @timer
    @timer += 1
    @adj[v].each do |to|
      next if to == p
      if @visited[to]
        @low[v] = [@low[v], @tin[to]].min
      else
        dfs(to, v)
        @low[v] = [@low[v], @low[to]].min
        if @low[to] > @tin[v]
          @bridges << [@nodes[v], @nodes[to]]
        end
      end
    end
  end
end

intersections.each(&:sort!)
intersections.sort!
intersections.uniq!
p nodes.size
p intersections.size
p intersections.combination(2).size
i = 0
# ex solution: ["bvb", "cmg"], ["hfx", "pzl"], ["jqt", "nvd"]
sol = 0
intersections.combination(2) do |i1, i2|
  # i1 = ["hfx", "pzl"]
  # i2 = ["jqt", "nvd"]
  i += 1
  p i if i % 1_000 == 0
  [i1, i2].each do |i|
    adj[i.first].delete(i.last)
    adj[i.last].delete(i.first)
  end
  tarjan = Tarjan.new(nodes, adj)
  tarjan.run!
  next unless tarjan.bridges.length == 1
  tarjan.bridges.each do |i|
    adj[i.first].delete(i.last)
    adj[i.last].delete(i.first)
  end
  g = n_groups(nodes.dup, adj)
  if g.size == 2
    # p [i1, i2, tarjan.bridges.first, g]
    sol = [sol, g.reduce(:*)].max
  end
  [i1, i2].each do |i|
    adj[i.first].add(i.last)
    adj[i.last].add(i.first)
  end
  tarjan.bridges.each do |i|
    adj[i.first].add(i.last)
    adj[i.last].add(i.first)
  end
end
puts sol
