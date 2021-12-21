INPUT = "59773590431003134109950482159532121838468306525505797662142691007448458436452137403459145576019785048254045936039878799638020917071079423147956648674703093863380284510436919245876322537671069460175238260758289779677758607156502756182541996384745654215348868695112673842866530637231316836104267038919188053623233285108493296024499405360652846822183647135517387211423427763892624558122564570237850906637522848547869679849388371816829143878671984148501319022974535527907573180852415741458991594556636064737179148159474282696777168978591036582175134257547127308402793359981996717609700381320355038224906967574434985293948149977643171410237960413164669930"

PATTERN_BITS = [0, 1, 0, -1]

def fft(input)
  input = input.length.times.map do |position|
    pattern_state = 0
    pattern_index = 0

    input.map do |i|
      pattern_index += 1

      if pattern_index > position
        pattern_index = 0

        pattern_state += 1
        pattern_state %= 4
      end

      pattern_bit = PATTERN_BITS[pattern_state]

      i * pattern_bit
    end.sum.abs % 10
  end

  input
end

def part_1
  input = INPUT.chars.map(&:to_i)

  100.times do
    input = fft(input)
  end

  input[0, 8].join
end

def fft_last_digits(input)
  res = []
  sum = 0

  input.reverse_each do |digit|
    sum += digit
    sum %= 10

    res << sum
  end

  res.reverse
end

def part_2
  input = INPUT.chars.map(&:to_i)
  input *= 10_000

  offset = input[0, 7].join.to_i
  input = input[offset..-1]

  100.times do
    input = fft_last_digits(input)
  end

  input[0, 8].join
end

puts part_1
puts part_2
