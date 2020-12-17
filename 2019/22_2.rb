def deal_into_new_stack!(deck)
  puts deck - 2020
end

def cut!(deck, n)
  if n < 0
    puts 2020 + n
  else
    puts 2020 + n
  end
end

def deal_with_increment!(deck, n)
  puts 2020 * n % deck
end

deck = 119315717514047

while s = gets
  s.chomp!

  puts s

  case s
  when /^deal into new stack/
    deal_into_new_stack!(deck)
  when /^deal with increment (\d+)$/
    deal_with_increment!(deck, $1.to_i)
  when /^cut -(\d+)$/
    cut!(deck, -$1.to_i)
  when /^cut (\d+)$/
    cut!(deck, $1.to_i)
  else
    raise "omg"
  end
end
