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

(1..2).each do |part|
  max_time = part == 2 ? 26 : 30
  max_pressure = 0
  queue = [{ valves: ["AA"] * part, open: {}, time: max_time, flow: 0, pressure: 0 }]
  visited = { queue.first[:valves] => queue.first.slice(:time, :flow, :pressure) }

  until queue.empty?
    node = queue.shift
    valves, time, open, flow, pressure = node.values_at(:valves, :time, :open, :flow, :pressure)

    next unless time > 0

    max_pressure = [max_pressure, pressure].max

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

    available_moves = part == 2 ? available_moves.reduce(:product) : available_moves.first.map { [_1] }

    available_moves.each do |moves|
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

  puts max_pressure
end
