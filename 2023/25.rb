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

class KargerAlgorithm
  def initialize(vertices, edges)
    @vertices = vertices
    @edges = edges
  end

  attr_reader :min_cut, :components, :min_cut_edges

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

    @min_cut = 0

    @edges.each do |u, w|
      uroot = find(u)
      wroot = find(w)

      if uroot != wroot
        @min_cut += 1
      end
    end

    @components = @vertices.each_with_object(Hash.new { |h, k| h[k] = [] }) do |vertex, h|
      h[find(vertex)] << vertex
    end.values

    @min_cut_edges = @edges.reject do |a, b|
      find(a) == find(b)
    end
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

loop do
  karger = KargerAlgorithm.new(vertices.to_a, edges.to_a)
  karger.execute
  if karger.min_cut == 3
    # p karger.components.map(&:sort)
    # p karger.min_cut_edges
    puts karger.components.map(&:length).reduce(:*)
    break
  end
end
