INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Wire
  attr_accessor :value, :gate

  def value
    return @value if instance_variable_defined?(:@value)
    @value = @gate.output
  end
end

class AndGate
  def initialize(i1, i2, o)
    @i1 = i1
    @i2 = i2
    @o = o
  end

  def output
    return @output if instance_variable_defined?(:@value)
    @output = @i1.value & @i2.value
  end
end

class OrGate
  def initialize(i1, i2, o)
    @i1 = i1
    @i2 = i2
    @o = o
  end

  def output
    return @output if instance_variable_defined?(:@value)
    @output = @i1.value | @i2.value
  end
end

class XorGate
  def initialize(i1, i2, o)
    @i1 = i1
    @i2 = i2
    @o = o
  end

  def output
    return @output if instance_variable_defined?(:@value)
    @output = @i1.value ^ @i2.value
  end
end

WIRES_INPUT, GATES_INPUT = INPUT.chunk { _1.empty? && nil }.map(&:last)

WIRES = Hash.new { |h, k| h[k] = Wire.new }

WIRES_INPUT.each_with_object(WIRES) do |l, h|
  name, value = l.split(": ")
  h[name].value = value.to_i == 1
end

GATES = GATES_INPUT.map do |l|
  input, output = l.split(" -> ")
  input1, op, input2 = input.split(" ")
  WIRES[output].gate = case op
  when "AND"
    AndGate.new(WIRES[input1], WIRES[input2], WIRES[output])
  when "OR"
    OrGate.new(WIRES[input1], WIRES[input2], WIRES[output])
  when "XOR"
    XorGate.new(WIRES[input1], WIRES[input2], WIRES[output])
  else
    raise "invalid op #{op.inspect}"
  end
end

z_wires = WIRES.keys.grep(/^z/).sort.reverse

part1 = WIRES.slice(*z_wires).map { |_k, v| v.value ? "1" : "0" }.join.to_i(2)
puts part1
