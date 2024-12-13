INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

machines = INPUT.chunk { _1.empty? && nil }.map do |_empty, machine_spec|
  button_a, button_b, price = machine_spec

  {
    button_a: button_a.split(": ").last.split(", ").map { _1.split("+").last.to_i },
    button_b: button_b.split(": ").last.split(", ").map { _1.split("+").last.to_i },
    price: price.split(": ").last.split(", ").map { _1.split("=").last.to_i },
  }
end

def min_tokens(machines)
  machines.sum do |machine|
    ax, ay = machine[:button_a]
    bx, by = machine[:button_b]
    px, py = machine[:price]

    # we're just solving a system of 2 eqs with 2 variables

    pb, qb = (py * ax - px * ay).divmod(ax * by - ay * bx)

    next 0 unless qb == 0

    pa, qa = (px - bx * pb).divmod(ax)

    next 0 unless qa == 0

    pa * 3 + pb
  end
end

puts min_tokens(machines)

machines.each do |machine|
  machine[:price].map! { _1 + 10000000000000 }
end

puts min_tokens(machines)
