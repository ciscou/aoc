p File.readlines('04.txt',chomp:1).count{|l|r,s=l.split(',').map{|r|l,h=r.split('-').map(&:to_i);l..h};r.cover?(s)||s.cover?(r)}
