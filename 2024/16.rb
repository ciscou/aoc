require_relative "../shared/utils"

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

class MyDijkstra < Dijkstra
  def initialize(reindeer_row, reindeer_col, reindeer_dr, reindeer_dc)
    @reindeer_row = reindeer_row
    @reindeer_col = reindeer_col
    @reindeer_dr = reindeer_dr
    @reindeer_dc = reindeer_dc

    @visited = {}
  end

  private

  def visited?(state)
    r, c, dr, dc, cost, _path = state

    return true if @visited[[r, c, dr, dc]] && @visited[[r, c, dr, dc]] < cost
    @visited[[r, c, dr, dc]] = cost

    false
  end

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


best = nil
paths = []

MyDijkstra.new(reindeer_row, reindeer_col, reindeer_dr, reindeer_dc).execute.each do |state|
  r, c, _dr, _dc, cost, path = state

  if GRID[r][c] == "E"
    best = cost if best.nil?
    break if cost > best

    paths << path
  end
end

puts best

set = Set.new
paths.each do |path|
  path.each { set.add _1 }
end
puts set.size
