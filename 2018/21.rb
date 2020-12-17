input = <<EOS
#ip 4
seti 123 0 3
bani 3 456 3
eqri 3 72 3
addr 3 4 4
seti 0 0 4
seti 0 5 3
bori 3 65536 5
seti 5557974 2 3
bani 5 255 2
addr 3 2 3
bani 3 16777215 3
muli 3 65899 3
bani 3 16777215 3
gtir 256 5 2
addr 2 4 4
addi 4 1 4
seti 27 9 4
seti 0 0 2
addi 2 1 1
muli 1 256 1
gtrr 1 5 1
addr 1 4 4
addi 4 1 4
seti 25 4 4
addi 2 1 2
seti 17 6 4
setr 2 2 5
seti 7 1 4
eqrr 3 0 2
addr 2 4 4
seti 5 7 4
EOS

lines = input.lines.map(&:chomp)

ip = lines.shift.split(" ").last.to_i

program = lines.map do |line|
  i, a, b, c = line.split(" ")

  [i, a.to_i, b.to_i, c.to_i]
end

registers = [0, 0, 0, 0, 0, 0]
registers[0] = 1079

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

  p registers[5] if registers[ip] == 6

  registers[ip] += 1
end
