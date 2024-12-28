INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

edges = Set.new
vertices = Set.new

INPUT.each do |line|
  a, b = line.split(": ")
  b = b.split(" ")
  vertices.add(a)
  b.each do
    vertices.add(_1)
    edges.add([a, _1].sort)
  end
end

class KargersAlgorithm
  def initialize(vertices, edges)
    @vertices = vertices
    @edges = edges
  end

  def execute
    @parent = @vertices.each_with_object({}) { |v, h| h[v] = v }
    @rank = @vertices.each_with_object({}) { |v, h| h[v] = 0 }

    v = @vertices.length

    while v > 2
      edge = @edges.sample
      u, w = edge

      uroot = find(u)
      wroot = find(w)

      if uroot != wroot
        v -= 1
        union(uroot, wroot)
      end

      @edges.delete(edge)
    end

    ans = 0

    @edges.each do |u, w|
      uroot = find(u)
      wroot = find(w)

      if uroot != wroot
        ans += 1
      end
    end

    ans
  end

  private

  def find(edge)
    parent = @parent[edge]
    return edge if parent == edge

    find(parent)
  end

  def union(x, y)
    xroot = find(x)
    yroot = find(y)

    if @rank[xroot] < @rank[yroot]
      @parent[xroot] = yroot
    elsif @rank[xroot] > @rank[yroot]
      @parent[yroot] = xroot
    else
      @parent[yroot] = xroot
      @rank[xroot] += 1
    end
  end
end

def find_superparent(parent, v)
  if parent[v] == v
    v
  else
    find_superparent(parent, parent[v])
  end
end

results = Set.new
1_000.times do
  alg = KargersAlgorithm.new(vertices.to_a, edges.to_a)
  res = alg.execute
  results << res
  if res == 3
    parent = alg.instance_variable_get(:@parent)
    superparent = {}
    parent.keys.each do |k|
      superparent[k] = find_superparent(parent, k)
    end
    p superparent.values.tally.values.reduce(:*)
    break
  end
end
