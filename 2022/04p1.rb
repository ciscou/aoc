p File.readlines('04.txt',chomp:1).count{|l|r,s=l.split(',').map{|r|l,h=r.split('-');l.to_i..h.to_i};r.cover?(s)||s.cover?(r)}
