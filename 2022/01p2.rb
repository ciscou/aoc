puts File.read('01.txt').split("\n\n").map{_1.split.sum(&:to_i)}.max(3).sum
