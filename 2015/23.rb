input = <<EOS
jio a, +16
inc a
inc a
tpl a
tpl a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
tpl a
tpl a
inc a
jmp +23
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
tpl a
inc a
inc a
tpl a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
tpl a
tpl a
inc a
jio a, +8
inc b
jie a, +4
tpl a
inc a
jmp +2
hlf a
jmp -7
EOS

instructions = input.lines.map do |line|
  line.chomp!

  case line
  when /^hlf (a|b)$/
    ["hlf", $1]
  when /^tpl (a|b)$/
    ["tpl", $1]
  when /^inc (a|b)$/
    ["inc", $1]
  when /^jmp ([+-][0-9]+)$/
    ["jmp", $1.to_i]
  when /^jie (a|b), ([+-][0-9]+)$/
    ["jie", $1, $2.to_i]
  when /^jio (a|b), ([+-][0-9]+)$/
    ["jio", $1, $2.to_i]
  else
    raise "cannot parse #{line.inspect}"
  end
end

p instructions
puts
puts
puts

pc = 0
registers = {
  "a" => 1,
  "b" => 0
}

while pc < instructions.length
  i, p1, p2 = instructions[pc]

  p instructions[pc]

  case i
  when "hlf"
    registers[p1] /= 2
    pc += 1
  when "tpl"
    registers[p1] *= 3
    pc += 1
  when "inc"
    registers[p1] += 1
    pc += 1
  when "jmp"
    pc += p1
  when "jie"
    if registers[p1].even?
      pc += p2
    else
      pc += 1
    end
  when "jio"
    if registers[p1] == 1
      pc += p2
    else
      pc += 1
    end
  else raise "invalid instruction #{i}"
  end
end

p registers
