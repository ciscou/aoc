def p(t)t-(t>90?96:38)end;puts File.readlines('03.txt',chomp:1).map(&:chars).each_slice(3).sum{|g|p g.reduce(:&).first.ord}
