input = <<EOS
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 826
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19
EOS

class Program
  def initialize(input, number, out_buffer, in_buffer)
    @program = input.lines.map(&:chomp)

    @registers = Hash.new { |h, k| h[k] = 0 }
    @registers["p"] = number

    @out_buffer = out_buffer
    @in_buffer = in_buffer

    @pc = 0

    @n_sends = 0
  end

  attr_reader :n_sends

  def running?
    @pc < @program.length
  end

  def waiting?
    !!@waiting
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

    @waiting = false

    case instruction
    when /^snd ([a-z])$/
      @out_buffer.push @registers[$1]
      @n_sends += 1
    when /^set ([a-z]) ([a-z])$/
      @registers[$1] = @registers[$2]
    when /^set ([a-z]) (-?[0-9]+)$/
      @registers[$1] = $2.to_i
    when /^add ([a-z]) ([a-z])$/
      @registers[$1] += @registers[$2]
    when /^add ([a-z]) (-?[0-9]+)$/
      @registers[$1] += $2.to_i
    when /^mul ([a-z]) ([a-z])$/
      @registers[$1] *= @registers[$2]
    when /^mul ([a-z]) (-?[0-9]+)$/
      @registers[$1] *= $2.to_i
    when /^mod ([a-z]) ([a-z])$/
      @registers[$1] %= @registers[$2]
    when /^mod ([a-z]) (-?[0-9]+)$/
      @registers[$1] %= $2.to_i
    when /^rcv ([a-z])$/
      if @in_buffer.empty?
        next_pc = @pc
        @waiting = true
      else
        @registers[$1] = @in_buffer.shift
      end
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
    else
      raise "cannot parse instruction #{instruction}"
    end

    @pc = next_pc
  end
end

buffer_0_1 = []
buffer_1_0 = []

program0 = Program.new(input, 0, buffer_0_1, buffer_1_0)
program1 = Program.new(input, 1, buffer_1_0, buffer_0_1)

while !(program0.waiting? && program1.waiting?) && (program0.running? || program1.running?)
  program0.tick
  program1.tick
end

puts program1.n_sends
