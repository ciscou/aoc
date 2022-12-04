p File.readlines('04.txt').count{r,s=_1.split(',').map{|r|l,h=r.split('-');l.to_i..h.to_i};r.cover?(s)||s.cover?(r)}
