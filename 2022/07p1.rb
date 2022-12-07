s,d=[],[];File.readlines('07.txt').each{|l|case l when/\$ cd \./;d.push s.pop when/\$ cd .*/;s.push 0 when/(\d+) .*/;s.map!{_1+$1.to_i}end};p d.reject{_1>100000}.sum
