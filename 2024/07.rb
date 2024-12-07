INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

equations = INPUT.map do |line|
  a, b = line.split(": ")
  [a.to_i, b.split(" ").map(&:to_i)]
end

def has_solution?(solution, numbers, part2: false)
  q = []
  q << numbers
  until q.empty?
    ns = q.pop
    a, b, *rest = ns
    if b.nil?
      return true if a == solution
    else
      q << [a + b, *rest]
      q << [a * b, *rest]
      q << ["#{a}#{b}".to_i, *rest] if part2
    end
  end
  false
end

part1 = equations.sum do |solution, numbers|
  if has_solution?(solution, numbers)
    solution
  else
    0
  end
end

puts part1

part2 = equations.sum do |solution, numbers|
  if has_solution?(solution, numbers, part2: true)
    solution
  else
    0
  end
end

puts part2
