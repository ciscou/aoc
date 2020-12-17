input = "0,12,6,13,20,1,17"

def partn(input, n)
  starting_numbers = input.split(",").map(&:to_i)

  numbers = starting_numbers
  last_number = numbers.first

  turns_by_number = Hash.new { |h, k| h[k] = [] }
  numbers.each_with_index do |n, i|
    turns = turns_by_number[n]
    turns << i
    turns.shift while turns.length > 2
  end

  while numbers.length < (n == 1 ? 2020 : 30000000)
    turns = turns_by_number[last_number]
    last_number = if turns.length > 1
                    turns[-1] - turns[-2]
                  else
                    0
                  end

    turns = turns_by_number[last_number]
    turns << numbers.length
    turns.shift while turns.length > 2

    numbers.push(last_number)
  end

  puts numbers.last
end

partn(input, 1)
partn(input, 2)
