input = <<EOS
cpy a b
dec b
cpy a d
cpy 0 a
cpy b c
inc a
dec c
jnz c -2
dec d
jnz d -5
dec b
cpy b c
cpy c d
dec d
inc c
jnz d -2
tgl c
cpy -16 c
jnz 1 c
cpy 71 c
jnz 72 d
inc a
inc d
jnz d -2
inc c
jnz c -5
EOS

# input = <<EOS
# cpy 2 a
# tgl a
# tgl a
# tgl a
# cpy 1 a
# dec a
# dec a
# EOS

instructions = input.lines.map do |line|
  line.chomp!

  case line
  when /^cpy (a|b|c|d|-?[0-9]+) (a|b|c|d)$/
    ["cpy", $1, $2]
  when /^inc (a|b|c|d)$/
    ["inc", $1]
  when /^dec (a|b|c|d)$/
    ["dec", $1]
  when /^jnz (a|b|c|d|[0-9]+) (a|b|c|d|-?[0-9]+)$/
    ["jnz", $1, $2]
  when /^tgl (a|b|c|d)$/
    ["tgl", $1]
  else
    raise "cannot parse #{line.inspect}"
  end
end

pc = 0
registers = {
  "a" => 12,
  "b" => 0,
  "c" => 0,
  "d" => 0
}

while pc < instructions.length
  instruction = instructions[pc]
  i, x, y = instruction

  case i
  when "cpy"
    registers[y] = registers.fetch(x, x.to_i) if registers.key?(y)
    pc += 1
  when "inc"
    registers[x] += 1 if registers.key?(x)
    pc += 1
  when "dec"
    registers[x] -= 1 if registers.key?(x)
    pc += 1
  when "jnz"
    if registers.fetch(x, x.to_i) == 0
      pc += 1
    else
      pc += registers.fetch(y, y.to_i)
    end
  when "tgl"
    offset = registers.fetch(x, x.to_i)
    other_instruction = instructions[pc + offset]
    if other_instruction
      case other_instruction.first
      when "inc"
        other_instruction[0] = "dec"
      when "jnz"
        other_instruction[0] = "cpy"
      else
        case other_instruction.length
        when 2
          other_instruction[0] = "inc"
        when 3
          other_instruction[0] = "jnz"
        else
          raise "uh oh... #{other_instruction.inspect}"
        end
      end
    end
    pc += 1
  else raise "invalid instruction #{i}"
  end
end

p registers
