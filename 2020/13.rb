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
  bus_ids_and_offsets = input.lines.last.split(",").map.with_index { |bus_id, offset| [bus_id == "x" ? nil : bus_id.to_i, offset] }.reject { |bus_id, offset| bus_id.nil? }

  crt = crt(bus_ids_and_offsets.map(&:last), bus_ids_and_offsets.map(&:first))

  puts crt.last - crt.first
end

# shamelessly stolen from https://linuxtut.com/en/f652d4941298a9842dfc/
def ext_gcd(a, b, values)
  d = a

  if b.zero?
    values[:x] = 1
    values[:y] = 0
  else
    d = ext_gcd(b, a % b, values)

    x = values[:x]
    y = values[:y]
    values[:x] = y
    values[:y] = x - (a / b) * y
  end

  d
end

def crt(b, m)
  r = 0
  mM = 1
  b.zip(m) do |bi, mi|
    val = {}
    d = ext_gcd(mM, mi, val)
    p = val[:x]
    q = val[:y]
    return [0, -1] if (bi - r) % d != 0
    tmp = (bi - r) / d * p % (mi / d)
    r += mM * tmp
    mM *= mi / d
  end

  [r % mM, mM]
end

part1(input)
part2(input)
