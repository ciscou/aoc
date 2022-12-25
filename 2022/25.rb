INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def i_to_snafu(n)
  snafu = ""

  while n > 0
    p, q = n.divmod 5

    case q
    when 4
      p += 1
      snafu = "-" + snafu
    when 3
      p += 1
      snafu = "=" + snafu
    else
      snafu = q.to_s + snafu
    end

    n = p
  end

  snafu
end

def snafu_to_i(snafu)
  weight = 1
  n = 0;

  snafu.chars.reverse_each do |char|
    case char
    when "-"
      n += weight * -1
    when "="
      n += weight * -2
    else
      n += weight * char.to_i
    end

    weight *= 5
  end

  n
end

sum = INPUT.sum { snafu_to_i(_1) }
puts i_to_snafu(sum)
