def deal_into_new_stack!(deck)
  deck.reverse!
end

def cut!(deck, n)
  if n < 0
    bottom = deck.pop(n * -1)
    deck.unshift(*bottom)
  else
    top = deck.shift(n)
    deck.push(*top)
  end
end

def deal_with_increment!(deck, n)
  new_deck = []

  deck.each_with_index do |card, i|
    new_deck[(i * n) % deck.length] = card
  end

  new_deck.each_with_index do |card, i|
    deck[i] = card
  end
end

deck = 119315717514047.times.to_a

p deck

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

p deck

p deck[2020]
