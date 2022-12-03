def p(t)t-(t>90?96:38)end;puts File.readlines('03.txt',chomp:1).map(&:chars).sum{|r|p r.each_slice(r.length/2).reduce(:&).first.ord}
