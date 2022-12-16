INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

adjacency = Hash.new { |h, k| h[k] = [] }
valves = {}

INPUT.each do |line|
  valve_flow_rate, tunnels = line.split("; ")

  _, valve, _, _, rate = valve_flow_rate.split
  valves[valve] = rate.split("=").last.to_i

  neighbours = tunnels.split(" ", 5).last.split(", ")
  adjacency[valve] = neighbours
end

part1 = 0
queue = [{ valv: "AA", open: {}, time: 30, flow: 0, pres: 0 }]
visited = { "AA" => { time: 30, flow: 0, pres: 0 } }

until queue.empty?
  node = queue.shift

  valv = node[:valv]
  time = node[:time]
  open = node[:open]
  flow = node[:flow]
  pres = node[:pres]

  next unless time > 0

  part1 = [part1, pres].max

  if !open[valv] && valves[valv] > 0
    queue.push(valv: valv, time: time - 1, open: open.merge(valv => true), flow: flow + valves[valv], pres: pres + flow + valves[valv])
  end

  adjacency[valv].each do |neig|
    v = visited[neig]
    next if v && v[:time] >= time - 1 && v[:flow] >= flow && v[:pres] >= pres

    visited[neig] = { time: time - 1, flow: flow, pres: pres }

    queue.push(valv: neig, time: time - 1, open: open, flow: flow, pres: pres + flow)
  end
end

puts part1

part2 = 0
queue = [{ valv: ["AA", "AA"], open: {}, time: 26, flow: 0, pres: 0 }]
visited = { ["AA", "AA"] => { time: 26, flow: 0, pres: 0 } }

until queue.empty?
  node = queue.shift

  valv = node[:valv]
  time = node[:time]
  open = node[:open]
  flow = node[:flow]
  pres = node[:pres]

  next unless time > 0

  if pres > part2
    part2 = pres
    # puts part2
  end

  available_moves = valv.map do |valv|
    moves = []

    if !open[valv] && valves[valv] > 0
      moves.push(valv: valv, open: valv)
    end

    adjacency[valv].each do |neig|
      moves.push(valv: neig, open: nil)
    end

    moves
  end

  available_moves.reduce(:product).each do |moves|
    next_valv = moves.map { _1[:valv] }.sort
    just_open = moves.map { _1[:open] }.compact.uniq - open.keys
    next_open = just_open.inject(open) { |a, e| a.merge(e => true) }
    extra_flow = just_open.sum { valves[_1] }
    next_flow = flow + extra_flow
    next_pres = pres + flow + extra_flow

    v = visited[next_valv]
    next if v && v[:time] >= time - 1 && v[:flow] >= next_flow && v[:pres] >= next_pres

    # p time - 1
    # p next_valv
    # p next_open
    # p extra_flow
    # gets

    visited[next_valv] = { time: time - 1, flow: next_flow, pres: next_pres }

    queue.push(valv: next_valv, time: time - 1, open: next_open, flow: next_flow, pres: next_pres)
  end
end

puts part2
