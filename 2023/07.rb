INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class Card
  def initialize(value, suit)
    @value = value
    @suit  = suit
  end

  attr_reader :value, :suit

  def numerical_value
    case @value
    when "T" then 10
    when "J" then 11
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

  def five_of_a_kind?
    @cards.group_by(&:value).select { |k, v| v.length == 5 }.length == 1
  end

  def four_of_a_kind?
    @cards.group_by(&:value).select { |k, v| v.length == 4 }.length == 1
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def three_of_a_kind?
    @cards.group_by(&:value).select { |k, v| v.length == 3 }.length == 1
  end

  def two_pairs?
    @cards.group_by(&:value).select { |k, v| v.length == 2 }.length == 2
  end

  def pair?
    @cards.group_by(&:value).select { |k, v| v.length == 2 }.length == 1
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

part1 = 0
HANDS_AND_BIDS.sort_by! { _1.first.power }
HANDS_AND_BIDS.each_with_index do |hand_and_bid, i|
  hand, bid = hand_and_bid
  p [hand.power, i+1, bid]
  part1 += (i + 1) * bid
end
puts part1
