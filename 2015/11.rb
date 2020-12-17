input = "vzbxkghb"

def valid_password?(password)
  rule_1?(password) &&
  rule_2?(password) &&
  rule_3?(password)
end

def rule_1?(password)
  password.chars.each_cons(3).any? { |a, b, c| c == b.next && b == a.next }
end

def rule_2?(password)
  %w[i o l].all? { |ss| password[ss].nil? }
end

def rule_3?(password)
  password.chars.chunk(&:itself).select { |chunk| chunk.last.length > 1 }.length > 1
end

begin
  input = input.next
end until valid_password?(input)

begin
  input = input.next
end until valid_password?(input)

puts input
