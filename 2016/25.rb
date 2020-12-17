input = <<EOS
cpy a d
cpy 7 c
cpy 365 b
inc d
dec b
jnz b -2
dec c
jnz c -5
cpy d a
jnz 0 0
cpy a b
cpy 0 a
cpy 2 c
jnz b 2
jnz 1 6
dec b
dec c
jnz c -4
inc a
jnz 1 -7
cpy 2 b
jnz c 2
jnz 1 4
dec b
dec c
jnz 1 -4
jnz 0 0
out b
jnz a -19
jnz 1 -21
EOS

target = 1000.times.map { |i| i % 2 }

target.length.times do |i|
  puts i

  outs = []

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
    when /^out (a|b|c|d|-?[0-9]+)$/
      ["out", $1]
    else
      raise "cannot parse #{line.inspect}"
    end
  end

  pc = 0
  registers = {
    "a" => i,
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
    when "out"
      val = registers.fetch(x, x.to_i)
      outs << val
      if outs.length >= target.length
        raise "found!!!" if outs == target
        break
      end
      pc += 1
    else raise "invalid instruction #{i}"
    end
  end
end
