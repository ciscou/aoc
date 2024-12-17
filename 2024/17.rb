INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def combo(literal, a, b, c)
  case literal
  when 0..3
    literal
  when 4
    a
  when 5
    b
  when 6
    c
  end
end

a = INPUT[0].split(": ").last.to_i
b = INPUT[1].split(": ").last.to_i
c = INPUT[2].split(": ").last.to_i

program = INPUT[4].split(": ").last.split(",").map(&:to_i)

def execute(program, a, b, c)
  pc = 0

  out = []

  loop do
    break unless pc < program.length

    literal = program[pc + 1]
    combo = combo(literal, a, b, c)

    case program[pc]
    when 0 # adv
      a = a / (2 ** combo)
    when 1 # bxl
      b = b ^ literal
    when 2 # bst
      b = combo(literal, a, b, c) % 8
    when 3 # jnz
      unless a == 0
        pc = literal - 2
      end
    when 4 # bxc
      b = b ^ c
    when 5 # out
      out << combo % 8
    when 6 # bdv
      b = a / (2 ** combo)
    when 7 # cdv
      c = a / (2 ** combo)
    end

    pc += 2
  end

  out
end

part1 = execute(program, a, b, c).join(",")
puts part1

a = 1

(1..program.length).each do |l|
  a += 1 until execute(program, a, b, c).last(l) == program.last(l)
  a *= 8
end

part2 = a / 8
puts part2
