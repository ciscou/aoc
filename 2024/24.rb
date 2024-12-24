INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Gate
  def initialize(output_name, *input_names)
    @output_name = output_name
    @input_names = input_names
  end

  attr_reader :output_name, :input_names

  private

  def input_values
    @input_names.map { GATES_BY_OUTPUT_NAME[_1].output_value }
  end
end

class OneGate < Gate
  def output_value
    1
  end
end

class ZeroGate < Gate
  def output_value
    0
  end
end

class AndGate < Gate
  def output_value
    input_values.reduce(:&)
  end
end

class OrGate < Gate
  def output_value
    input_values.reduce(:|)
  end
end

class XorGate < Gate
  def output_value
    input_values.reduce(:^)
  end
end

WIRES_INPUT, GATES_INPUT = INPUT.chunk { _1.empty? && nil }.map(&:last)

GATES = [
  WIRES_INPUT.map do |l|
    name, value = l.split(": ")

    value.to_i == 1 ? OneGate.new(name) : ZeroGate.new(name)
  end,

  GATES_INPUT.map do |l|
    input, output = l.split(" -> ")
    input1, op, input2 = input.split(" ")

    case op
    when "AND"
      AndGate.new(output, input1, input2)
    when "OR"
      OrGate.new(output, input1, input2)
    when "XOR"
      XorGate.new(output, input1, input2)
    else
      raise "invalid op #{op.inspect}"
    end
  end
].flatten

GATES_BY_OUTPUT_NAME = GATES.each_with_object({}) do |gate, h|
  h[gate.output_name] = gate
end

z_outputs = GATES_BY_OUTPUT_NAME.keys.grep(/^z/).sort.reverse
z = z_outputs.map { |g| GATES_BY_OUTPUT_NAME[g].output_value }.join.to_i(2)

part1 = z
puts part1

def find_gate(klass, input_names, swaps)
  input_names.map! { swaps.fetch(_1, _1) }.sort!

  gate = GATES.grep(klass).detect do |g|
    g.input_names.sort == input_names
  end

  return gate if gate

  gate = GATES.grep(klass).detect do |g|
    input_names.any? { g.input_names.include?(_1) }
  end

  missing_input_name = (input_names - gate.input_names).first
  extra_input_name = (gate.input_names - input_names).first

  swaps[missing_input_name] = extra_input_name
  swaps[extra_input_name] = missing_input_name

  gate
end

swaps = {}
cout = nil

45.times do |i|
  cin = cout

  x = "x#{i.to_s.rjust(2, "0")}"
  y = "y#{i.to_s.rjust(2, "0")}"

  xor1 = find_gate(XorGate, [x, y], swaps)
  and1 = find_gate(AndGate, [x, y], swaps)

  cout = and1

  if cin
    _xor2 = find_gate(XorGate, [xor1.output_name, cin.output_name], swaps)
    and2 = find_gate(AndGate, [xor1.output_name, cin.output_name], swaps)
    or1 = find_gate(OrGate, [and1.output_name, and2.output_name], swaps)

    cout = or1
  end
end

part2 = swaps.keys.sort.join(",")
puts part2
