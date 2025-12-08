INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def flood_fill(adj, from, seen, to = nil)
  return true if from == to
  return if seen[from]
  seen[from] = true

  adj[from].keys.any? { flood_fill(adj, it, seen, to) }
end

boxes = INPUT.map { it.split(",").map(&:to_i) }

pairs = boxes.combination(2).map do |boxes1, boxes2|
  { boxes1: boxes1, boxes2: boxes2, distance: boxes1.zip(boxes2).sum { |p1, p2| (p1 - p2) ** 2 } }
end.sort_by { it[:distance] }

adj = Hash.new { |h, k| h[k] = {} }

pairs.first(1000).each_with_index do |pair, i|
  seen = {}
  next if flood_fill(adj, pair[:boxes1], seen, pair[:boxes2])

  adj[pair[:boxes1]][pair[:boxes2]] = true
  adj[pair[:boxes2]][pair[:boxes1]] = true
end

seen = {}
sizes = []

boxes.each do |box|
  next if seen[box]

  seen_size_was = seen.size
  flood_fill(adj, box, seen)
  sizes << seen.size - seen_size_was
end

puts sizes.sort.last(3).reduce(:*)

part2 = 0

pairs.drop(1000).each_with_index do |pair, i|
  seen = {}
  next if flood_fill(adj, pair[:boxes1], seen, pair[:boxes2])

  adj[pair[:boxes1]][pair[:boxes2]] = true
  adj[pair[:boxes2]][pair[:boxes1]] = true

  part2 = pair[:boxes1].first * pair[:boxes2].first
end

puts part2
