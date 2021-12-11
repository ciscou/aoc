class Deck
  def initialize(size, card)
    @size = size
    @card = card
  end

  attr_reader :card

  def deal_into_new_stack!
    @card = (-card - 1) % @size
  end

  def cut!(n)
    @card = (card - n) % @size
  end

  def deal_with_increment!(n)
    @card = (card * n) % @size
  end
end

def part1
  deck = Deck.new(10007, 2019)

  while s = gets
    s.chomp!

    case s
    when /^deal into new stack$/
      deck.deal_into_new_stack!
    when /^deal with increment (\d+)$/
      deck.deal_with_increment!($1.to_i)
    when /^cut -(\d+)$/
      deck.cut!(-$1.to_i)
    when /^cut (\d+)$/
      deck.cut!($1.to_i)
    else
      raise "omg"
    end
  end

  deck.card
end

def inv(a, n)
  a.pow(n - 2, n)
end

def part2
  # stolen from https://topaz.github.io/paste/#XQAAAQAgBQAAAAAAAAAzHIoib6pENkSmUIKIED8dy140D1lKWSMhNhZz+hjKgIgfJKPuwdqIBP14lxcYH/qI+6TyUGZUnsGhS4MQYaEtf9B1X3qIIO2JSejFjoJr8N1aCyeeRSnm53tWsBtER8F61O2YFrnp7zwG7y303D8WR4V0eGFqtDhF/vcF1cQdZLdxi/WhfyXZuWC+hs8WQCBmEtuId6/G0PeMA1Fr78xXt96Um/CIiLCievFE2XuRMAcBDB5We73jvDO95Cjg0CF2xgF4yt3v4RB9hmxa+gmt6t7wRI4vUIGoD8kX2k65BtmhZ7zSZk1Hh5p1obGZ6nuuFIHS7FpuSuv1faQW/FuXlcVmhJipxi37mvPNnroYrDM3PFeMw/2THdpUwlNQj0EDsslC7eSncZQPVBhPAHfYojh/LlqSf4DrfsM926hSS9Fdjarb9xBYjByQpAxLDcmDCMRFH5hkmLYTYDVguXbOCHcY+TFbl+G/37emZRFh/d+SkeGqbFSf64HJToM2I7N2zMrWP7NDDY5FWehD5gzKsJpEg34+sG7x2O82wO39qBlYHcYg1Gz4cLBrH1K1P+KWvEdcdj/NBtrl6yftMlCu6pH4WTGUe9oidaiRuQZOGtw71QsTQUuhpdoWO4mEH0U9+CiPZCZLaQolFDSky1J9nDhZZHy3+ETcUeDOfSu+HI3WuKC0AtIRPdG8B9GhtxZQKAx+5kyi/ek7A2JAY9SjrTuvRADxx5AikbHWXIsegZQkupAc2msammSkwY8dRMk0ilf5vh6kR0jHNbSi0g0KJLCJfqggeX24fKk5Mdh8ULZXnMfMZOmwEGfegByYbu91faLijfW4hoXCB1nlsWTPZEw2PCZqqhl9oc1q25H2YkkvKLxEZWl6a9eFuRzxhB840I1zdBjUVgfKd9/V4VdodzU2Z2e+VEh7RbJjQNFC/rG8dg==

  n = 119315717514047
  m = 101741582076661
  c = 2020

  a, b = 1, 0

  while s = gets
    s.chomp!

    la, lb = case s
             when /^deal into new stack$/
               [-1, -1]
             when /^deal with increment (\d+)$/
               [$1.to_i, 0]
             when /^cut -(\d+)$/
               [1, $1.to_i]
             when /^cut (\d+)$/
               [1, -$1.to_i]
             else
               raise "omg"
             end

    # la * (a * x + b) + lb == la * a * x + la*b + lb
    # The `% n` doesn't change the result, but keeps the numbers small.

    a = (la * a) % n
    b = (la * b + lb) % n
  end

  # Now want to morally run:
  # la, lb = a, b
  # a = 1, b = 0
  # for i in range(M):
  #     a, b = (a * la) % n, (la * b + lb) % n

  # For a, this is same as computing (a ** M) % n, which is in the computable
  # realm with fast exponentiation.
  # For b, this is same as computing ... + a**2 * b + a*b + b
  # == b * (a**(M-1) + a**(M) + ... + a + 1) == b * (a**M - 1)/(a-1)
  # That's again computable, but we need the inverse of a-1 mod n.

  ma = a.pow(m, n)
  mb = (b * (ma - 1) * inv(a-1, n)) % n

  # This computes "where does 2020 end up", but I want "what is at 2020".
  # (ma * c + mb) % n

  # So need to invert (2020 - MB) * inv(Ma)
  ((c - mb) * inv(ma, n)) % n
end

puts part2
