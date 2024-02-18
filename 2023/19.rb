INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

ratings = []

def A(x, m, a, s)
  true
end

def R(x, m, a, s)
  false
end

state = :workflows
INPUT.each do |line|
  if line.empty?
    state = :ratings
    next
  end

  case state
  when :workflows
    name, rules = line.split("{")
    rules.delete_suffix!("}")
    rules = rules.split(",")
    define_method(name) do |x, m, a, s|
      rules.each do |rule|
        cond, workflow = rule.split(":")
        if !workflow
          workflow = cond
          cond = "true"
        end
        if eval(cond)
          return send(workflow, x, m, a, s)
        end
      end
    end
  when :ratings
    ratings << eval(line.gsub("=", ":"))
  else
    raise "invalid state #{state.inspect}"
  end
end

part1 = ratings.sum do |rating|
  if send(:in, rating[:x], rating[:m], rating[:a], rating[:s])
    rating[:x] + rating[:m] + rating[:a] + rating[:s]
  else
    0
  end
end

puts part1

def part2_helper(name, x_range, m_range, a_range, s_range)
  ranges = {
    "x" => x_range,
    "m" => m_range,
    "a" => a_range,
    "s" => s_range,
  }

  return 0 if name == "R"
  return ranges.values.map(&:size).reduce(:*) if name == "A"

  RULES[name].sum do |rule|
    next_ranges = {
      "x" => ranges["x"],
      "m" => ranges["m"],
      "a" => ranges["a"],
      "s" => ranges["s"],
    }
    cond, workflow = rule.split(":")
    if workflow
      var = cond[0]
      comp = cond[1]
      val = cond[2..].to_i
      case comp
      when "<"
        ranges[var] = ranges[var].begin..(val-1)
        next_ranges[var] = val..next_ranges[var].end
      when ">"
        ranges[var] = (val+1)..ranges[var].end
        next_ranges[var] = next_ranges[var].begin..val
      else
        raise "invalid comp #{comp.inspect}"
      end
      tmp = part2_helper(workflow, ranges["x"], ranges["m"], ranges["a"], ranges["s"])
      ranges = next_ranges
      tmp
    else
      part2_helper(cond, ranges["x"], ranges["m"], ranges["a"], ranges["s"])
    end
  end
end

RULES = {}

INPUT.each do |line|
  break if line.empty?

  name, rules = line.split("{")
  rules.delete_suffix!("}")
  rules = rules.split(",")

  RULES[name] = rules
end

puts part2_helper("in", 1..4000, 1..4000, 1..4000, 1..4000)
