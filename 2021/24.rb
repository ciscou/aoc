INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Program
  def initialize
    @instrs = INPUT.map do |line|
      instr, a, b = line.split(" ")
      b = b.to_i unless %w[w x y z].include?(b)

      [instr, a, b]
    end
  end

  def run(input)
    registers = { "w" => 0, "x" => 0, "y" => 0, "z" => 0 }

    @instrs.each do |instr, a, b|
      b = registers[b] if %w[w x y z].include?(b)

      case instr
      when "inp"
        registers[a] = input.shift
      when "add"
        registers[a] += b
      when "mul"
        registers[a] *= b
      when "div"
        registers[a] /= b
      when "mod"
        registers[a] %= b
      when "eql"
        registers[a] = registers[a] == b ? 1 : 0
      else
        raise "Invalid instruction #{instr.inspect}"
      end
    end

    registers["z"]
  end

  def run_faster(input)
    w = x = y = z = 0

    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 1
    x += 13
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 6
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 1
    x += 11
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 11
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 1
    x += 12
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 5
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 1
    x += 10
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 6
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 1
    x += 14
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 8
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 26
    x += -1
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 14
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 1
    x += 14
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 9
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 26
    x += -16
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 4
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 26
    x += -8
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 7
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 1
    x += 12
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 13
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 26
    x += -16
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 11
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 26
    x += -13
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 11
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 26
    x += -6
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 6
    y *= x
    z += y
    w = input.shift
    x *= 0
    x += z
    x %= 26
    z /= 26
    x += -6
    x = x == w ? 1 : 0
    x = x == 0 ? 1 : 0
    y *= 0
    y += 25
    y *= x
    y += 1
    z *= y
    y *= 0
    y += w
    y += 1
    y *= x
    z += y

    z
  end

  def run_even_faster(input)
    w = x = y = z = 0

    [
      [ 1,  13,  6],
      [ 1,  11, 11],
      [ 1,  12,  5],
      [ 1,  10,  6],
      [ 1,  14,  8],
      [26,  -1, 14],
      [ 1,  14,  9],
      [26, -16,  4],
      [26,  -8,  7],
      [ 1,  12, 13],
      [26, -16, 11],
      [26, -13, 11],
      [26,  -6,  6],
      [26,  -6,  1]
    ].each do |a, b, c|
      w = input.shift
      x = z % 26 + b
      z /= a

      unless x == w
        z *= 26
        z += w + c
      end
    end

    z
  end
end


program = Program.new

puts program.run(12345678912345.to_s.chars.map(&:to_i))
puts program.run_faster(12345678912345.to_s.chars.map(&:to_i))
puts program.run_even_faster(12345678912345.to_s.chars.map(&:to_i))
exit(0)

guesses = []

1000_000_000.times do
  input = 14.times.map { (1..9).to_a.sample }
  res = program.run_faster(input.dup)
  puts [input.join, res].inspect if res < 100
  guesses << [input.join.to_i, res] if res < 1_000
end

guesses.sort_by!(&:last)

puts guesses[0, 1_000].reverse.map(&:inspect)
