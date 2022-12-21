INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

MONKEYS = INPUT.inject({}) do |monkeys, line|
  id, job_definition = line.split(": ")

  job = case job_definition
        when /\A(\d+)\z/
          { op: :number, number: $1.to_i }
        when /\A(\w+) \+ (\w+)\z/
          { op: :add, dependencies: [$1, $2] }
        when /\A(\w+) - (\w+)\z/
          { op: :sub, dependencies: [$1, $2] }
        when /\A(\w+) \* (\w+)\z/
          { op: :mul, dependencies: [$1, $2] }
        when /\A(\w+) \/ (\w+)\z/
          { op: :div, dependencies: [$1, $2] }
        else
          unreachable
        end

  monkeys.merge(id => job)
end

def monkey_number(monkey_id)
  monkey = MONKEYS[monkey_id]

  return monkey[:number] if monkey[:op] == :number

  op, dependencies = monkey[:op], monkey[:dependencies]
  dep1, dep2 = dependencies

  case op
  when :add
    monkey_number(dep1) + monkey_number(dep2)
  when :sub
    monkey_number(dep1) - monkey_number(dep2)
  when :mul
    monkey_number(dep1) * monkey_number(dep2)
  when :div
    monkey_number(dep1) / monkey_number(dep2)
  else
    unreachable
  end
end

part1 = monkey_number("root")
puts part1

humn = MONKEYS["humn"]
root = MONKEYS["root"]
dep1, dep2 = root[:dependencies]
part2 = (1_000_000_000..1_000_000_000_000_000).bsearch do |humn_number|
  humn[:number] = humn_number
  monkey_number(dep2) >= monkey_number(dep1)
end
puts part2
