INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)
PART2 = true

class Card
  def initialize(value, suit)
    @value = value
    @suit  = suit
  end

  attr_reader :value, :suit

  def numerical_value
    case @value
    when "T" then 10
    when "J" then PART2 ? 1 : 11
    when "Q" then 12
    when "K" then 13
    when "A" then 14
    else          @value.to_i
    end
  end
end

class PokerHand
  def initialize(cards)
    @cards = cards
  end

  attr_reader :cards

  def <=>(other)
    power <=> other.power
  end

  def power
    kind_power = if five_of_a_kind?
      7
    elsif four_of_a_kind?
      6
    elsif full_house?
      5
    elsif three_of_a_kind?
      4
    elsif two_pairs?
      3
    elsif pair?
      2
    elsif high_card?
      1
    else
      raise "WTF (What a Terrible Failure)"
    end

    [kind_power] + cards.map(&:numerical_value)
  end

  def kind
    if five_of_a_kind?
      :five_of_a_kind
    elsif four_of_a_kind?
      :four_of_a_kind
    elsif full_house?
      :full_house
    elsif three_of_a_kind?
      :three_of_a_kind
    elsif two_pairs?
      :two_pairs
    elsif pair?
      :pair
    elsif high_card?
      :high
    else
      raise "WTF (What a Terrible Failure)"
    end
  end

  def njokers
    PART2 ? @cards.count { _1.value == "J" } : 0
  end

  def for_any_joker_combination?
    res = false
    original_cards = @cards
    %w[A K Q T 9 8 7 6 5 4 3 2].repeated_combination(njokers) do |extra_cards|
      @cards = @cards.reject { _1.value == "J" } if PART2
      @cards += extra_cards.map { Card.new(_1, "X") }
      res ||= yield
      @cards = original_cards
    end
    res
  end

  def five_of_a_kind?
    return true if njokers > 3

    for_any_joker_combination? do
      @cards.group_by(&:value).select { |k, v| v.length == 5 }.length == 1
    end
  end

  def four_of_a_kind?
    return true if njokers > 2

    for_any_joker_combination? do
      @cards.group_by(&:value).select { |k, v| v.length == 4 }.length == 1
    end
  end

  def full_house?
    for_any_joker_combination? do
      cards_by_value = @cards.group_by(&:value)
      three = cards_by_value.select { |k, v| v.length == 3 }.length == 1
      two = cards_by_value.select { |k, v| v.length == 2 }.length == 1
      three && two
    end
  end

  def three_of_a_kind?
    for_any_joker_combination? do
      @cards.group_by(&:value).select { |k, v| v.length == 3 }.length == 1
    end
  end

  def two_pairs?
    for_any_joker_combination? do
      @cards.group_by(&:value).select { |k, v| v.length == 2 }.length == 2
    end
  end

  def pair?
    for_any_joker_combination? do
      @cards.group_by(&:value).select { |k, v| v.length == 2 }.length == 1
    end
  end

  def high_card?
    true
  end

  def highest_card
    @cards.sort_by(&:numerical_value).last
  end
end

HANDS_AND_BIDS = INPUT.map do |line|
  hand, bid = line.split

  [
    PokerHand.new(hand.chars.map { Card.new(_1, "X") }),
    bid.to_i,
  ]
end

res = 0
HANDS_AND_BIDS.sort_by! { _1.first.power }
HANDS_AND_BIDS.each_with_index do |hand_and_bid, i|
  res += (i + 1) * hand_and_bid.last
end
puts res
