puts File.readlines('03.txt',chomp:1).map(&:chars).each_slice(3).sum{|g|o=g.reduce(:&).first.ord;o-(o>90?96:38)}
