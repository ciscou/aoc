INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

a, b, c = 3.times.map { INPUT[_1].split(": ").last.to_i }
program = INPUT[4].split(": ").last.split(",").map(&:to_i)

def execute(program, a, b, c)
  pc = 0

  out = []

  loop do
    break unless pc < program.length

    instruction = program[pc]
    literal = program[pc + 1]
    pc += 2

    combo = [literal, literal, literal, literal, a, b, c].at(literal)

    case instruction
    when 0 # adv
      a = a / (2 ** combo)
    when 1 # bxl
      b = b ^ literal
    when 2 # bst
      b = combo % 8
    when 3 # jnz
      unless a == 0
        pc = literal
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
  end

  out
end

part1 = execute(program, a, b, c).join(",")
puts part1

a = 0
program.length.times do |l|
  a *= 8
  a += 1 until execute(program, a, b, c) == program.last(l + 1)
end

part2 = a
puts part2
