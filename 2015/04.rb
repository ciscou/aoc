require "digest"

input = "iwrupvqb"

1_000_000_000_000.times.lazy.detect do |i|
  md5 = Digest::MD5.hexdigest("#{input}#{i}")

  if md5[0, 6] == "000000"
    puts i
    true
  end
end
