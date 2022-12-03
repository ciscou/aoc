puts File.readlines('03.txt',chomp:1).map(&:chars).sum{|r|o=r.each_slice(r.length/2).reduce(:&).first.ord;o-(o>90?96:38)}
