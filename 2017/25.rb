input = <<EOS
Begin in state A.
Perform a diagnostic checksum after 12302209 steps.

In state A:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state B.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state D.

In state B:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state C.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the right.
    - Continue with state F.

In state C:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state C.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.

In state D:
  If the current value is 0:
    - Write the value 0.
    - Move one slot to the left.
    - Continue with state E.
  If the current value is 1:
    - Write the value 1.
    - Move one slot to the right.
    - Continue with state A.

In state E:
  If the current value is 0:
    - Write the value 1.
    - Move one slot to the left.
    - Continue with state A.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the right.
    - Continue with state B.

In state F:
  If the current value is 0:
    - Write the value 0.
    - Move one slot to the right.
    - Continue with state C.
  If the current value is 1:
    - Write the value 0.
    - Move one slot to the right.
    - Continue with state E.
EOS

instructions = Hash.new { |h, state| h[state] = { 0 => [], 1 => [] } }
initial_state = nil
state = nil
value = nil
steps = nil

input.lines.each do |line|
  line.chomp!

  case line
  when /^Begin in state ([A-Z])\.$/
    initial_state = $1
  when /^Perform a diagnostic checksum after ([0-9]+) steps.$/
    steps = $1.to_i
  when /^In state ([A-Z]):$/
    state = $1
  when /^  If the current value is ([01]):$/
    value = $1.to_i
  when /^    - Write the value ([01])\.$/
    instructions[state][value] << $1.to_i
  when /^    - Move one slot to the (left|right)\.$/
    instructions[state][value] << ($1 == "left" ? -1 : 1)
  when /^    - Continue with state ([A-Z])\.$/
    instructions[state][value] << $1
  when /^$/
    # skip blank lines
  else
    raise "cannot parse line #{line.inspect}"
  end
end

tape = Hash.new(0)
position = 0

state = initial_state

steps.times do
  value, move, next_state = instructions[state][tape[position]]

  tape[position] = value
  position += move
  state = next_state
end

puts tape.values.select { |v| v == 1 }.length
