input = 33100000
n = 1_000_000

houses = n.times.map { 0 }

n.times do |elf|
  next if elf == 0

  start = elf
  n = 0
  while start < houses.length && n < 50
    houses[start] += 11 * elf
    start += elf
    n += 1
  end
end

res = houses.each_with_index.detect { |h, i| h > input }
p res
