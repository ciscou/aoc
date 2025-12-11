require_relative "../shared/utils"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

flow = INPUT.each_with_object({}) do |line, h|
  a, bs = line.split(": ")
  h[a] = bs.split(" ")
end

class Part1BFS < BFS
  def initialize(flow, from)
    @flow = flow
    @from = from
  end

  def initial_state
    @from
  end

  def visited?(_state)
    false
  end

  def neighbours(state)
    @flow[state] || []
  end
end

part1 = 0

my_bfs = Part1BFS.new(flow, "you")
my_bfs.execute.each do |state|
  part1 += 1 if state == "out"
end

puts part1

class Part2BFS < BFS
  def initialize(flow)
    @flow = flow
    @seen = Set.new
  end

  def initial_state
    ["svr", false, false]
  end

  def visited?(state)
    # !@seen.add?(state)
  end

  def neighbours(state)
    node, dac, fft = state
    dac = true if node == "dac"
    fft = true if node == "fft"

    (@flow[node] || []).map { [it, dac, fft] }
  end
end
