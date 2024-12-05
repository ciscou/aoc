INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

rules_lines, updates_lines = INPUT.chunk { _1.empty? && nil }.map(&:last)

rules = rules_lines.map { _1.split("|").map(&:to_i) }.group_by(&:first)
updates = updates_lines.map { _1.split(",").map(&:to_i) }

valid_updates = updates.select do |update|
  valid = true
  seen = Set.new
  update.each do |n|
    if rules[n] && rules[n].any? { |_, m| seen.include? m  }
      valid = false
    end
    seen.add(n)
  end
  valid
end

part1 = valid_updates.sum { _1[_1.length / 2] }
puts part1
