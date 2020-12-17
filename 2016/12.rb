input = <<EOS
cpy 1 a
cpy 1 b
cpy 26 d
jnz c 2
jnz 1 5
cpy 7 c
inc d
dec c
jnz c -2
cpy a c
inc a
dec b
jnz b -2
cpy c b
dec d
jnz d -6
cpy 14 c
cpy 14 d
inc a
dec d
jnz d -2
dec c
jnz c -5
EOS

instructions = input.lines.map do |line|
  line.chomp!

  case line
  when /^cpy (a|b|c|d|[0-9]+) (a|b|c|d)$/
    ["cpy", $1, $2]
  when /^inc (a|b|c|d)$/
    ["inc", $1]
  when /^dec (a|b|c|d)$/
    ["dec", $1]
  when /^jnz (a|b|c|d|[0-9]+) (-?[0-9]+)$/
    ["jnz", $1, $2.to_i]
  else
    raise "cannot parse #{line.inspect}"
  end
end

pc = 0
registers = {
  "a" => 0,
  "b" => 0,
  "c" => 1,
  "d" => 0
}

while pc < instructions.length
  i, x, y = instructions[pc]

  case i
  when "cpy"
    registers[y] = registers.fetch(x, x.to_i)
    pc += 1
  when "inc"
    registers[x] += 1
    pc += 1
  when "dec"
    registers[x] -= 1
    pc += 1
  when "jnz"
    if registers.fetch(x, x.to_i) == 0
      pc += 1
    else
      pc += y
    end
  else raise "invalid instruction #{i}"
  end
end

p registers
