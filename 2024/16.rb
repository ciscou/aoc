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

class Dijkstra
  def initialize(reindeer_row, reindeer_col, reindeer_dr, reindeer_dc)
    @reindeer_row = reindeer_row
    @reindeer_col = reindeer_col
    @reindeer_dr = reindeer_dr
    @reindeer_dc = reindeer_dc
  end

  def execute
    visited = {}

    pq = PriorityQueue.new
    pq.push(state: initial_state, priority: priority(initial_state))

    best = nil
    paths = []

    loop do
      node = pq.pop
      break if node.nil?

      state = node[:state]

      r, c, dr, dc, cost, path = state

      if GRID[r][c] == "E"
        best = cost if best.nil?
        break if cost > best

        paths << path
      end

      next if visited[[r, c, dr, dc]] && visited[[r, c, dr, dc]] < cost
      visited[[r, c, dr, dc]] = cost

      neighbours(state).each do |next_state|
        pq.push(state: next_state, priority: priority(next_state))
      end
    end

    [best, paths]
  end

  private

  def initial_state
    [
      @reindeer_row,
      @reindeer_col,
      @reindeer_dr,
      @reindeer_dc,
      0,
      [
        [
          @reindeer_row,
          @reindeer_col,
        ],
      ],
    ]
  end

  def neighbours(state)
    r, c, dr, dc, cost, path = state

    ns = []

    ns << [
      r + dr,
      c + dc,
      dr,
      dc,
      cost + 1,
      path + [[r + dr, c + dc]],
    ]

    if dr == 0
      ns << [
        r,
        c,
        1,
        0,
        cost + 1_000,
        path,
      ]
      ns << [
        r,
        c,
        -1,
        0,
        cost + 1_000,
        path,
      ]
    else
      ns << [
        r,
        c,
        0,
        1,
        cost + 1_000,
        path,
      ]
      ns << [
        r,
        c,
        0,
        -1,
        cost + 1_000,
        path,
      ]
    end

    ns.select do |r, c, _dr, _dc, _cost, _path|
      next false if r < 0
      next false if c < 0
      next false unless r < H
      next false unless c < W

      next false if GRID[r][c] == "#"

      true
    end
  end

  def priority(state)
    _r, _c, _dr, _dc, cost, _path = state
    -cost
  end
end

best, paths = Dijkstra.new(reindeer_row, reindeer_col, reindeer_dr, reindeer_dc).execute

puts best

set = Set.new
paths.each do |path|
  path.each { set.add _1 }
end
puts set.size
