m=File.readlines('11.txt').chunk{_1=="\n"&&nil}.map{|_,c|_,s,o,*t=c;[s.split(": ").last.split(", ").map(&:to_i),o.split.last(3).join,t.map{_1.split.last.to_i},0]}
20.times{m.each{|k|until k[0].empty?do w,o,t=k;old=w.shift;l=eval(o)/3;m[l%t[0]==0?t[1]:t[2]][0]<<l;k[3]+=1end}}
p m.map(&:last).max(2).reduce(:*)
