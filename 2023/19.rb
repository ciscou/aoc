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
