INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

state = :reading_rules
RULES = {}
messages = []

INPUT.each do |line|
  if line == ""
    state = :reading_messages
  else
    if state == :reading_rules
      id, specs = line.split(": ")
      RULES[id] = case specs
                  when '"a"', '"b"'
                    {id: id, type: :char, char: specs[1]}
                  else
                    {id: id, type: :others, others: specs.split(" | ").map { |rs| rs.split(" ") }}
                  end
    else
      messages << line
    end
  end
end

def message_matches_rule?(message, rule)
  case rule[:type]
  when :char
    [message[0] == rule[:char], message[1..-1]]
  when :others
    md = [false, nil]

    rule[:others].any? do |other_rules|
      md = [true, message]

      other_rules.each do |other_rule|
        if md.first
          md = message_matches_rule?(md.last, RULES[other_rule])
        end
      end

      md.first
    end

    md
  else
    raise "invalid rule type #{rule[:type].inspect}"
  end
end

part1 = messages.count do |message|
  md = message_matches_rule?(message, RULES["0"])
  md.first && md.last.empty?
end

puts part1

EXPANDED_RULE_CACHE = {}

def expand(rule_id)
  EXPANDED_RULE_CACHE[rule_id] ||= begin
    rule = RULES[rule_id]

    case rule[:type]
    when :char
      [rule[:char]]
    when :others
      res = []

      rule[:others].each do |other_rules|
        expansions = other_rules.map do |other_rule|
          expand(other_rule)
        end

        expansions[0].product(*expansions[1..-1]).each do |expansion|
          res << expansion.join
        end
      end

      # we want to return ["aaab", "aaba", "bbab", "bbba"]
      res
    else
      raise "invalid rule type #{rule[:type].inspect}"
    end
  end
end

expansion42 = expand("42").group_by(&:itself)
expansion31 = expand("31").group_by(&:itself)

# puts expansion42["abaaa"].inspect
# puts expansion31["abaaa"].inspect

# puts expansion42.keys.map(&:length).sort.uniq
# puts expansion31.keys.map(&:length).sort.uniq

part2 = messages.count do |message|
  slices = message.chars.each_slice(8).map(&:join)

  matches42 = slices.map { |slice| !!expansion42[slice] }
  matches31 = slices.map { |slice| !!expansion31[slice] }

  count_matches31 = matches31.count(&:itself)

  next false unless count_matches31 < (slices.size.fdiv 2).ceil
  next false unless matches31[-count_matches31..-1].all?(&:itself)
  next false unless matches42[0..-count_matches31-1].all?(&:itself)

  true
end

puts part2
