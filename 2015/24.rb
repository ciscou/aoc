input = <<EOS
1
3
5
11
13
17
19
23
29
31
37
41
43
47
53
59
67
71
73
79
83
89
97
101
103
107
109
113
EOS

weights = input.lines.map(&:to_i)

total_weight = weights.sum

target = total_weight / 4

first_group = weights.combination(5).select { |ws| ws.sum == target }.sort_by { |ws| ws.inject(:*) }.first
second_group = (weights - first_group).combination(7).detect { |ws| ws.sum == target }
third_group = (weights - first_group - second_group).combination(7).detect { |ws| ws.sum == target }
fourth_group = weights - first_group - second_group - third_group

p first_group
p second_group
p third_group
p fourth_group
p first_group.inject(:*)
