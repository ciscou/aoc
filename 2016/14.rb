require "digest"

input = "yjdafjpo"

$cache = {}

def stretch(md5)
  return $cache[md5] if $cache.key?(md5)

  res = md5

  2016.times do
    res = Digest::MD5.hexdigest(res)
  end

  $cache[md5] = res
end

def valid_pad_key_index?(input, index)
  md5 = Digest::MD5.hexdigest("#{input}#{index}")
  md5 = stretch(md5)
  repeated_char = nil
  return false unless md5.chars.each_cons(3).any? do |a, b, c|
    repeated_char = a
    a == b && b == c
  end

  1000.times.any? do |i|
    md5 = Digest::MD5.hexdigest("#{input}#{index + i + 1}")
    md5 = stretch(md5)
    md5.chars.each_cons(5).any? do |chars|
      chars.all? { |c| c == repeated_char }
    end
  end
end

pad_keys = 0
index = 0

while pad_keys < 64
  p [pad_keys, index]

  if md5 = valid_pad_key_index?(input, index)
    pad_keys += 1
  end

  index += 1
end

puts index - 1
