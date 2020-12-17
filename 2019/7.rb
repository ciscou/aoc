require_relative "intcode"

source = "3,8,1001,8,10,8,105,1,0,0,21,38,63,76,93,118,199,280,361,442,99999,3,9,101,3,9,9,102,3,9,9,101,4,9,9,4,9,99,3,9,1002,9,2,9,101,5,9,9,1002,9,5,9,101,5,9,9,1002,9,4,9,4,9,99,3,9,101,2,9,9,102,3,9,9,4,9,99,3,9,101,2,9,9,102,5,9,9,1001,9,5,9,4,9,99,3,9,102,4,9,9,1001,9,3,9,1002,9,5,9,101,2,9,9,1002,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,99"

class Pipe
  def initialize
    @buffer = []
  end

  def write(val)
    @buffer << val
  end

  def read
    @buffer.shift
  end
end

class Amplifier < Intcode
  def initialize(source, input, output)
    super(source)

    @input = input
    @output = output
  end

  def input
    @input.read
  end

  def output(val)
    @output.write(val)
  end
end

highest_output = 0
highest_perm = nil

(5..9).to_a.permutation.each do |perm|
  puts "trying perm #{perm.inspect}"

  pipes = 5.times.map do |i|
    Pipe.new.tap do |pipe|
      pipe.write perm[i]
    end
  end

  pipes.first.write 0

  amps = 5.times.map do |i|
    Amplifier.new(source, pipes[i], pipes[i+1] || pipes.first)
  end

  until amps.all?(&:halt?)
    amps.each(&:tick)
  end

  output = pipes.first.read

  puts "output #{output}"

  if output > highest_output
    highest_output = output
    highest_perm = perm
  end
end

puts "highest output: #{highest_output} highest_perm: #{highest_perm.inspect}"
