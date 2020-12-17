input = <<EOS
#ip 4
addi 4 16 4
seti 1 8 1
seti 1 3 5
mulr 1 5 3
eqrr 3 2 3
addr 3 4 4
addi 4 1 4
addr 1 0 0
addi 5 1 5
gtrr 5 2 3
addr 4 3 4
seti 2 2 4
addi 1 1 1
gtrr 1 2 3
addr 3 4 4
seti 1 4 4
mulr 4 4 4
addi 2 2 2
mulr 2 2 2
mulr 4 2 2
muli 2 11 2
addi 3 6 3
mulr 3 4 3
addi 3 8 3
addr 2 3 2
addr 4 0 4
seti 0 1 4
setr 4 4 3
mulr 3 4 3
addr 4 3 3
mulr 4 3 3
muli 3 14 3
mulr 3 4 3
addr 2 3 2
seti 0 4 0
seti 0 7 4
EOS

lines = input.lines.map(&:chomp)

ip = lines.shift.split(" ").last.to_i

program = lines.map do |line|
  i, a, b, c = line.split(" ")

  [i, a.to_i, b.to_i, c.to_i]
end

registers = [0, 0, 0, 0, 0, 0]
registers[0] = 1
registers[ip] = 0

while registers[ip] < program.length
  i, a, b, c = program[registers[ip]]

  registers[c] = case i
                 when "addr" then registers[a] + registers[b]
                 when "addi" then registers[a] + b
                 when "mulr" then registers[a] * registers[b]
                 when "muli" then registers[a] * b
                 when "banr" then registers[a] & registers[b]
                 when "bani" then registers[a] & b
                 when "borr" then registers[a] | registers[b]
                 when "bori" then registers[a] | b
                 when "setr" then registers[a]
                 when "seti" then a
                 when "gtir" then a > registers[b] ? 1 : 0
                 when "gtri" then registers[a] > b ? 1 : 0
                 when "gtrr" then registers[a] > registers[b] ? 1 : 0
                 when "eqir" then a == registers[b] ? 1 : 0
                 when "eqri" then registers[a] == b ? 1 : 0
                 when "eqrr" then registers[a] == registers[b] ? 1 : 0
                 else raise "invalid instruction name #{i}"
                 end

  registers[ip] += 1
end

puts registers[0]
