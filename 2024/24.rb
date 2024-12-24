INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Wire
  attr_accessor :name, :value, :gate

  def initialize(name)
    @name = name
  end

  def value
    return @value if instance_variable_defined?(:@value)
    @value = @gate.output
  end
end

class Gate
  def initialize(inputs)
    @inputs = inputs
  end

  attr_reader :inputs

  def input_names
    inputs.map(&:name)
  end

  def output
    return @output if instance_variable_defined?(:@output)
    @output = calculate_output
  end
end

class AndGate < Gate
  private

  def calculate_output
    @inputs.map(&:value).reduce(:&)
  end
end

class OrGate < Gate
  private

  def calculate_output
    @inputs.map(&:value).reduce(:|)
  end
end

class XorGate < Gate
  private

  def calculate_output
    @inputs.map(&:value).reduce(:^)
  end
end

WIRES_INPUT, GATES_INPUT = INPUT.chunk { _1.empty? && nil }.map(&:last)

WIRES = Hash.new { |h, k| h[k] = Wire.new(k) }

WIRES_INPUT.each_with_object(WIRES) do |l, h|
  name, value = l.split(": ")

  h[name].value = value.to_i == 1
end

GATES = GATES_INPUT.map do |l|
  input, output = l.split(" -> ")

  input1, op, input2 = input.split(" ")
  WIRES[output].gate = case op
  when "AND"
    AndGate.new([WIRES[input1], WIRES[input2]])
  when "OR"
    OrGate.new([WIRES[input1], WIRES[input2]])
  when "XOR"
    XorGate.new([WIRES[input1], WIRES[input2]])
  else
    raise "invalid op #{op.inspect}"
  end
end

z_wires = WIRES.keys.grep(/^z/).sort.reverse
z = z_wires.map { |w| WIRES[w].value ? "1" : "0" }.join.to_i(2)

part1 = z
puts part1

def find_output_wire(klass, input_names, swaps)
  input_names.map! { swaps.fetch(_1, _1) }.sort!

  wire = WIRES.values.detect do |w|
    next unless w.gate.is_a? klass
    next unless w.gate.input_names.sort == input_names

    true
  end

  return wire if wire

  wire = WIRES.values.detect do |w|
    next unless w.gate.is_a? klass
    next unless input_names.any? { w.gate.input_names.include?(_1) }

    true
  end

  missing_input_name = (input_names - wire.gate.input_names).first
  extra_input_name = (wire.gate.input_names - input_names).first

  swaps[missing_input_name] = extra_input_name
  swaps[extra_input_name] = missing_input_name

  wire
end

swaps = {}
cout = nil

45.times do |i|
  cin = cout

  x = "x#{i.to_s.rjust(2, "0")}"
  y = "y#{i.to_s.rjust(2, "0")}"

  xor1 = find_output_wire(XorGate, [x, y], swaps)
  and1 = find_output_wire(AndGate, [x, y], swaps)

  cout = and1

  if cin
    _xor2 = find_output_wire(XorGate, [xor1.name, cin.name], swaps)
    and2 = find_output_wire(AndGate, [xor1.name, cin.name], swaps)
    or1 = find_output_wire(OrGate, [and1.name, and2.name], swaps)

    cout = or1
  end
end

part2 = swaps.keys.sort.join(",")
puts part2
