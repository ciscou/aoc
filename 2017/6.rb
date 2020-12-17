input = "14	0	15	12	11	11	3	5	1	6	8	4	9	1	8	4"

memory_banks = input.split(/\s+/).map(&:to_i)

def perform_cycle!(memory_banks)
  max = memory_banks.max
  idx = memory_banks.index(max)

  memory_banks[idx] = 0

  max.times do |i|
    memory_banks[(idx + i + 1) % memory_banks.length] += 1
  end
end

seen = {}
cycles = 0

loop do
  cycles += 1

  perform_cycle!(memory_banks)

  memory_banks_hash = memory_banks.join(",")
  break if seen[memory_banks_hash]

  seen[memory_banks_hash] = true
end

p cycles

cycles = 0

memory_banks_hash = memory_banks.join(",")

loop do
  cycles += 1

  perform_cycle!(memory_banks)

  break if memory_banks_hash == memory_banks.join(",")
end

p cycles
