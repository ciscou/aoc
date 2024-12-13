INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

machines = INPUT.chunk { _1.empty? && nil }.map do |_empty, machine_spec|
  button_a, button_b, price = machine_spec

  {
    button_a: button_a.split(": ").last.split(", ").map { _1.split("+").last.to_i },
    button_b: button_b.split(": ").last.split(", ").map { _1.split("+").last.to_i },
    price: price.split(": ").last.split(", ").map { _1.split("=").last.to_i },
  }
end

part1 = 0

machines.each do |machine|
  tokens = Float::INFINITY

  101.times do |a|
    101.times do |b|
      if machine[:button_a][0] * a + machine[:button_b][0] * b == machine[:price][0] &&
         machine[:button_a][1] * a + machine[:button_b][1] * b == machine[:price][1]
        tokens = [tokens, 3 * a + b].min
      end
    end
  end

  part1 += tokens if tokens.finite?
end

puts part1
