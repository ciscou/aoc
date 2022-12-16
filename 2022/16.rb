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

  visited[valv] = { time: time, flow: flow, pres: pres }

  next unless time > 0

  if pres > part1
    part1 = pres
    puts part1
  end

  if !open[valv] && valves[valv] > 0
    queue.push(valv: valv, time: time - 1, open: open.merge(valv => true), flow: flow + valves[valv], pres: pres + flow + valves[valv])
  end

  adjacency[valv].each do |neig|
    v = visited[neig]
    next if v && v[:time] >= time - 1 && v[:flow] >= flow && v[:pres] >= pres

    queue.push(valv: neig, time: time - 1, open: open, flow: flow, pres: pres + flow)
  end
end

puts part1
