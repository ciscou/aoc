input = <<EOS
set b 67
set c b
jnz a 2
jnz 1 5
mul b 100
sub b -100000
set c b
sub c -17000
set d 2
set e b
mod e d
jnz e 2
jnz 1 6
sub d -1
set g d
sub g b
jnz g -7
jnz 1 2
sub h -1
set g b
sub g c
jnz g 2
jnz 1 3
sub b -17
jnz 1 -16
EOS

class Program
  def initialize(input)
    @program = input.lines.map(&:chomp)

    @registers = Hash.new { |h, k| h[k] = 0 }

    @pc = 0

    @muls = 0
  end

  attr_reader :muls, :registers

  def running?
    @pc < @program.length
  end

  def run
    while running?
      tick
    end
  end

  def tick
    return unless running?

    instruction = @program[@pc]
    next_pc = @pc + 1

    case instruction
    when /^set ([a-z]) ([a-z])$/
      @registers[$1] = @registers[$2]
    when /^set ([a-z]) (-?[0-9]+)$/
      @registers[$1] = $2.to_i
    when /^add ([a-z]) ([a-z])$/
      @registers[$1] += @registers[$2]
    when /^add ([a-z]) (-?[0-9]+)$/
      @registers[$1] += $2.to_i
    when /^sub ([a-z]) ([a-z])$/
      @registers[$1] -= @registers[$2]
    when /^sub ([a-z]) (-?[0-9]+)$/
      @registers[$1] -= $2.to_i
    when /^mul ([a-z]) ([a-z])$/
      @registers[$1] *= @registers[$2]
      @muls += 1
    when /^mul ([a-z]) (-?[0-9]+)$/
      @registers[$1] *= $2.to_i
      @muls += 1
    when /^mod ([a-z]) ([a-z])$/
      @registers[$1] %= @registers[$2]
    when /^mod ([a-z]) (-?[0-9]+)$/
      @registers[$1] %= $2.to_i
    when /^jgz ([a-z]) ([a-z])$/
      if @registers[$1] > 0
        next_pc = @pc + @registers[$2]
      end
    when /^jgz ([a-z]) (-?[0-9]+)$/
      if @registers[$1] > 0
        next_pc = @pc + $2.to_i
      end
    when /^jgz (-?[0-9]+) ([a-z])$/
      if $1.to_i > 0
        next_pc = @pc + @registers[$2]
      end
    when /^jgz (-?[0-9]+) (-?[0-9]+)$/
      if $1.to_i > 0
        next_pc = @pc + $2.to_i
      end
    when /^jnz ([a-z]) ([a-z])$/
      if @registers[$1] != 0
        next_pc = @pc + @registers[$2]
      end
    when /^jnz ([a-z]) (-?[0-9]+)$/
      if @registers[$1] != 0
        next_pc = @pc + $2.to_i
      end
    when /^jnz (-?[0-9]+) ([a-z])$/
      if $1.to_i != 0
        next_pc = @pc + @registers[$2]
      end
    when /^jnz (-?[0-9]+) (-?[0-9]+)$/
      if $1.to_i != 0
        next_pc = @pc + $2.to_i
      end
    else
      raise "cannot parse instruction #{instruction}"
    end

    @pc = next_pc
  end
end

# program = Program.new(input)
# program.registers["a"] = 1
# program.run
# puts "muls"
# puts program.muls
# puts "h"
# puts program.registers["h"]

require "prime"
res = (106700..123700).step(17).reject(&Prime.method(:prime?))
puts res.length
