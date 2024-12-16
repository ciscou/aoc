# stolen from https://gist.github.com/brianstorti/e20300eb2e7d62b87849
class PriorityQueue
  attr_reader :elements

  def initialize
    @elements = [nil]
  end

  def <<(element)
    @elements << element
    bubble_up(@elements.size - 1)
  end

  alias_method :push, :<<

  def pop
    exchange(1, @elements.size - 1)
    max = @elements.pop
    bubble_down(1)
    max
  end

  private

  def bubble_up(index)
    parent_index = (index / 2)

    return if index <= 1
    return if @elements[parent_index][:priority] >= @elements[index][:priority]

    exchange(index, parent_index)
    bubble_up(parent_index)
  end

  def bubble_down(index)
    child_index = (index * 2)

    return if child_index > @elements.size - 1

    not_the_last_element = child_index < @elements.size - 1
    left_element = @elements[child_index]
    right_element = @elements[child_index + 1]
    child_index += 1 if not_the_last_element && right_element[:priority] > left_element[:priority]

    return if @elements[index][:priority] >= @elements[child_index][:priority]

    exchange(index, child_index)
    bubble_down(child_index)
  end

  def exchange(source, target)
    @elements[source], @elements[target] = @elements[target], @elements[source]
  end
end

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

GRID = INPUT.map(&:chars)
H = GRID.length
W = GRID.first.length

reindeer_row = nil
reindeer_col = nil
reindeer_dr = 0
reindeer_dc = 1

H.times do |r|
  W.times do |c|
    if GRID[r][c] == "S"
      GRID[r][c] = "."
      reindeer_row = r
      reindeer_col = c
    end
  end
end

pq = PriorityQueue.new

pq.push(state: [reindeer_row, reindeer_col, reindeer_dr, reindeer_dc, [[reindeer_row, reindeer_col]]], priority: 0)

visited = {}

best = nil
paths = []

loop do
  node = pq.pop
  break if node.nil?

  state, priority = node.values_at(:state, :priority)

  cost = -priority

  r, c, dr, dc, path = state

  next if r < 0
  next if c < 0
  next unless r < H
  next unless c < W

  next if GRID[r][c] == "#"

  if GRID[r][c] == "E"
    best = cost if best.nil?
    break if cost > best

    paths << path
  end

  next if visited[[r, c, dr, dc]] && visited[[r, c, dr, dc]] < cost
  visited[[r, c, dr, dc]] = cost

  pq.push(state: [r + dr, c + dc, dr, dc, path + [[r + dr, c + dc]]], priority: -(cost + 1))

  if dr == 0
    pq.push(state: [r, c, 1, 0, path], priority: -(cost + 1000))
    pq.push(state: [r, c, -1, 0, path], priority: -(cost + 1000))
  else
    pq.push(state: [r, c, 0, 1, path], priority: -(cost + 1000))
    pq.push(state: [r, c, 0, -1, path], priority: -(cost + 1000))
  end
end

puts best

set = Set.new
paths.each do |path|
  path.each { set.add _1 }
end
puts set.size
