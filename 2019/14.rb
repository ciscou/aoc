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

def calculate_ore_for(amount, chemical)
  leftovers = Hash.new(0)
  reaction = REACTION_TO_PRODUCE[chemical]

  inputs = reaction[:inputs].each_with_object(Hash.new(0)) { |(k, v), h| h[k] = v * amount }

  while input = inputs.detect { |k, v| k != "ORE" }
    input_chemical, input_amount = input
    inputs.delete(input_chemical)

    lo = [input_amount, leftovers[input_chemical]].min
    leftovers[input_chemical] -= lo
    input_amount -= lo

    r = REACTION_TO_PRODUCE[input_chemical]
    n = (input_amount.fdiv(r[:output])).ceil
    r[:inputs].each do |i|
      c, a = i
      inputs[c] += n * a
    end
    leftovers[input_chemical] += n * r[:output] - input_amount
  end

  inputs["ORE"]
end

puts calculate_ore_for(1, "FUEL")

low, high = 0, 1_000_000_000_000
while (high - low) > 1
  mid = (low + high) / 2

  if calculate_ore_for(mid, "FUEL") > 1_000_000_000_000
    high = mid
  else
    low = mid
  end
end

p [low, high]
