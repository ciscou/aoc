INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

rules_lines, updates_lines = INPUT.chunk { _1.empty? && nil }.map(&:last)

rules = rules_lines.map { _1.split("|").map(&:to_i) }
updates = updates_lines.map { _1.split(",").map(&:to_i) }

rules_by_first = rules.group_by(&:first)

valid_updates, invalid_updates = updates.partition do |update|
  valid = true
  seen = Set.new
  update.each do |n|
    if (rules_by_first[n] || []).any? { |_, m| seen.include? m  }
      valid = false
    end
    seen.add(n)
  end
  valid
end

part1 = valid_updates.sum { _1[_1.length / 2] }
puts part1

def fix_ordering(update, rules)
  fixed = []
  need = update.to_set

  loop do
    break if need.empty?

    ns = need.select do |m|
      (rules[m] || []).map(&:first).none? { need.include?(_1) }
    end
    raise "expected 1 value but got #{ns.inspect}" unless ns.length == 1
    n = ns.first

    fixed << n
    need.delete(n)
  end

  fixed
end

rules_by_last = rules.group_by(&:last)

part2 = invalid_updates.map { fix_ordering(_1, rules_by_last) }.sum { _1[_1.length / 2] }
puts part2
