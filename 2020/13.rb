input = <<EOS
1011416
41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,911,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,x,x,x,x,23,x,x,x,x,x,29,x,827,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19
EOS

def part1(input)
  earliest = input.lines.first.to_i
  bus_ids = input.lines.last.split(",").reject { |x| x == "x" }.map(&:to_i)

  def first_multiple_gte(n, m)
    res = n

    while res < m
      res += n
    end

    res
  end

  gtes = bus_ids.map { |id| first_multiple_gte(id, earliest) }

  gte_by_bus_id = Hash[bus_ids.zip(gtes)]

  winner = bus_ids.min_by { |id| gte_by_bus_id[id] }

  puts winner * (gte_by_bus_id[winner] - earliest)
end

def part2(input)
  problem = input.lines.last.split(",").map.with_index { |bus_id, offset| [bus_id == "x" ? nil : bus_id.to_i, offset] }.reject { |bus_id, offset| bus_id.nil? }.each do |a, b|
    puts "#{a.to_s.rjust(3, " ")} * n = t + #{b}"
  end
end

part1(input)
part2(input)
