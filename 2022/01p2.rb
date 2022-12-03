puts File.readlines('01.txt',chomp:1).chunk{|l|l.empty?&&nil}.map{|_,c|c.sum(&:to_i)}.sort[-3,3].sum
