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

  def reset_value
    remove_instance_variable(:@value)
  end
end

class AndGate
  def initialize(i1, i2, o)
    @i1 = i1
    @i2 = i2
    @o = o
  end

  attr_reader :i1, :i2

  def output
    return @output if instance_variable_defined?(:@output)
    @output = @i1.value & @i2.value
  end

  def reset_output
    remove_instance_variable(:@output)
  end
end

class OrGate
  def initialize(i1, i2, o)
    @i1 = i1
    @i2 = i2
    @o = o
  end

  attr_reader :i1, :i2

  def output
    return @output if instance_variable_defined?(:@output)
    @output = @i1.value | @i2.value
  end

  def reset_output
    remove_instance_variable(:@output)
  end
end

class XorGate
  def initialize(i1, i2, o)
    @i1 = i1
    @i2 = i2
    @o = o
  end

  attr_reader :i1, :i2

  def output
    return @output if instance_variable_defined?(:@output)
    @output = @i1.value ^ @i2.value
  end

  def reset_output
    remove_instance_variable(:@output)
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
z = WIRES.slice(*z_wires).map { |_k, v| v.value ? "1" : "0" }.join.to_i(2)

part1 = z
puts part1

cout = nil
45.times do |i|
  x = "x#{i.to_s.rjust(2, "0")}"
  y = "y#{i.to_s.rjust(2, "0")}"
  cin = cout

  xor1 = WIRES.values.detect do |w|
    next unless w.gate
    next unless w.gate.class.name == "XorGate"

    next unless [w.gate.i1.name, w.gate.i2.name].sort == [x, y].sort

    true
  end

  and1 = WIRES.values.detect do |w|
    next unless w.gate
    next unless w.gate.class.name == "AndGate"

    next unless [w.gate.i1.name, w.gate.i2.name].sort == [x, y].sort

    true
  end

  xor2 = nil
  and2 = nil
  cout = and1.name

  if cin
    xor2 = WIRES.values.detect do |w|
      next unless w.gate
      next unless w.gate.class.name == "XorGate"

      next unless [w.gate.i1.name, w.gate.i2.name].sort == [xor1.name, cin].sort

      true
    end

    and2 = WIRES.values.detect do |w|
      next unless w.gate
      next unless w.gate.class.name == "AndGate"

      xor1_name = xor1.name
      cin = "fhc" if cin == "z06" # swap 1
      xor1_name = "ggt" if xor1_name == "mwh" # swap 3

      next unless [w.gate.i1.name, w.gate.i2.name].sort == [xor1_name, cin].sort

      true
    end

    raise "cannot find and2 at index #{i} with inputs #{xor1.name}, #{cin}" unless and2

    or1 = WIRES.values.detect do |w|
      next unless w.gate
      next unless w.gate.class.name == "OrGate"

      and1_name = and1.name
      and1_name = "mwh" if and1_name == "ggt" # swap 3
      and1_name = "hqk" if and1_name == "z35" # swap 4

      and2_name = and2.name
      and2_name = "qhj" if and2_name == "z11" # swap 2

      next unless [w.gate.i1.name, w.gate.i2.name].sort == [and1_name, and2_name].sort

      true
    end

    raise "cannot find or1 at index #{i} with inputs #{and1.name}, #{and2.name}" unless or1

    cout = or1.name
  end
end
