class Program
  PARAMS = [
    [ 1,  13,  6, 26 ** 7],
    [ 1,  11, 11, 26 ** 7],
    [ 1,  12,  5, 26 ** 7],
    [ 1,  10,  6, 26 ** 7],
    [ 1,  14,  8, 26 ** 7],
    [26,  -1, 14, 26 ** 7],
    [ 1,  14,  9, 26 ** 6],
    [26, -16,  4, 26 ** 6],
    [26,  -8,  7, 26 ** 5],
    [ 1,  12, 13, 26 ** 4],
    [26, -16, 11, 26 ** 4],
    [26, -13, 11, 26 ** 3],
    [26,  -6,  6, 26 ** 2],
    [26,  -6,  1, 26 ** 1]
  ]

  def initialize
    @cache = {}
  end

  def find_ws_that_makes_z_0(i, z_was, candidate_digits)
    @cache[[i, z_was]] ||= do_find_ws_that_makes_z_0(i, z_was, candidate_digits)
  end

  def do_find_ws_that_makes_z_0(i, z_was, candidate_digits)
    unless i < PARAMS.length
      if z_was == 0
        return []
      else
        return nil
      end
    end

    a, b, c, maxz = PARAMS[i]

    return nil unless z_was < maxz

    candidate_digits.each do |w|
      z = z_was
      x = z % 26 + b
      z /= a

      unless x == w
        z *= 26
        z += w + c
      end

      ws = find_ws_that_makes_z_0(i + 1, z, candidate_digits)

      return [w] + ws unless ws.nil?
    end

    return nil
  end
end


puts Program.new.find_ws_that_makes_z_0(0, 0, (9..1).step(-1)).join
puts Program.new.find_ws_that_makes_z_0(0, 0, (1..9)).join
