INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

flow = INPUT.each_with_object({}) do |line, h|
  a, bs = line.split(": ")
  h[a] = bs.split(" ")
end

nodes_to = Hash.new { |h, k| h[k] = [] }

flow.each do |k, vs|
  vs.each do |v|
    nodes_to[v] << k
  end
end

def build_cache_from(nodes_to, from)
  Hash.new do |h, k|
    if k == from
      h[k] = 1
    else
      h[k] = nodes_to[k].sum { h[it] }
    end
  end
end

cache_from_you = build_cache_from(nodes_to, "you")
part1 = cache_from_you["out"]
puts part1

cache_from_svr = build_cache_from(nodes_to, "svr")
cache_from_fft = build_cache_from(nodes_to, "fft")
cache_from_dac = build_cache_from(nodes_to, "dac")

part2 = [
  cache_from_svr["dac"] * cache_from_dac["fft"] * cache_from_fft["out"],
  cache_from_svr["fft"] * cache_from_fft["dac"] * cache_from_dac["out"]
].sum

puts part2
