INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

REACTION_TO_PRODUCE = INPUT.each_with_object({}) do |line, h|
  input, output = line.split(" => ")
  output_quantity, output_name = output.split(" ")

  h[output_name] = {
    inputs: input.split(", ").each_with_object({}) do |part, h|
      quantity, name = part.split(" ")

      h[name] = quantity.to_i
    end,
    output: output_quantity.to_i
  }
end

def calculate_ore_for(amount, chemical, leftovers = nil)
  return amount if chemical == "ORE"
  return 0 if amount == 0

  leftovers ||= Hash.new(0)

  reaction = REACTION_TO_PRODUCE[chemical]
  n = (amount.fdiv(reaction[:output])).ceil
  leftovers[chemical] += n * reaction[:output] - amount

  reaction[:inputs].sum do |k, v|
    v *= n
    lo = [v, leftovers[k]].min
    v -= lo
    leftovers[k] -= lo

    calculate_ore_for(v, k, leftovers)
  end
end

puts calculate_ore_for(1, "FUEL")

low = 1_000_000_000_000 / calculate_ore_for(1, "FUEL")
high = low * 2

while (high - low) > 1
  mid = (low + high) / 2

  if calculate_ore_for(mid, "FUEL") > 1_000_000_000_000
    high = mid
  else
    low = mid
  end
end

puts low
