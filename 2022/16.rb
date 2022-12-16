INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

adjacency = Hash.new { |h, k| h[k] = [] }
valve_flow_rate = {}

INPUT.each do |line|
  valve, tunnels = line.split("; ")

  _, valve, _, _, rate = valve.split
  valve_flow_rate[valve] = rate.split("=").last.to_i

  neighbours = tunnels.split(" ", 5).last.split(", ")
  adjacency[valve] = neighbours
end

part1 = 0
queue = [{ valve: "AA", open: {}, time: 30, flow: 0, pressure: 0 }]
visited = { queue.first[:valve] => queue.first.slice(:time, :flow, :pressure) }

until queue.empty?
  node = queue.shift
  valve, time, open, flow, pressure = node.values_at(:valve, :time, :open, :flow, :pressure)

  next unless time > 0

  part1 = [part1, pressure].max

  if !open[valve] && valve_flow_rate[valve] > 0
    queue.push(
      valve: valve,
      time: time - 1,
      open: open.merge(valve => true),
      flow: flow + valve_flow_rate[valve],
      pressure: pressure + flow + valve_flow_rate[valve],
    )
  end

  adjacency[valve].each do |next_valve|
    v = visited[next_valve]
    next if v && v[:time] >= time - 1 && v[:flow] >= flow && v[:pressure] >= pressure

    visited[next_valve] = { time: time - 1, flow: flow, pressure: pressure }
    queue.push(valve: next_valve, time: time - 1, open: open, flow: flow, pressure: pressure + flow)
  end
end

puts part1

part2 = 0
queue = [{ valves: ["AA", "AA"], open: {}, time: 26, flow: 0, pressure: 0 }]
visited = { queue.first[:valves] => queue.first.slice(:time, :flow, :pressure) }

until queue.empty?
  node = queue.shift
  valves, time, open, flow, pressure = node.values_at(:valves, :time, :open, :flow, :pressure)

  next unless time > 0

  part2 = [part2, pressure].max

  available_moves = valves.map do |valve|
    moves = []

    if !open[valve] && valve_flow_rate[valve] > 0
      moves.push(valve: valve, open: valve)
    end

    adjacency[valve].each do |next_valve|
      moves.push(valve: next_valve, open: nil)
    end

    moves
  end

  available_moves.reduce(:product).each do |moves|
    next_valves = moves.map { _1[:valve] }.sort
    just_open = moves.map { _1[:open] }.compact.uniq - open.keys
    next_open = just_open.inject(open) { |a, e| a.merge(e => true) }
    next_flow = flow + just_open.sum { valve_flow_rate[_1] }
    next_pressure = pressure + next_flow

    v = visited[next_valves]
    next if v && v[:time] >= time - 1 && v[:flow] >= next_flow && v[:pressure] >= next_pressure

    visited[next_valves] = { time: time - 1, flow: next_flow, pressure: next_pressure }

    queue.push(valves: next_valves, time: time - 1, open: next_open, flow: next_flow, pressure: next_pressure)
  end
end

puts part2
