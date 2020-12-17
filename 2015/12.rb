require 'json'

def sum(o)
  case o
  when Hash then o.values.include?("red") ? 0 : o.values.sum { |e| sum(e) }
  when Array then o.sum { |e| sum(e) }
  when Numeric then o
  when String then 0
  else raise o.class.name
  end
end

h = JSON.parse(gets)

puts sum(h)
