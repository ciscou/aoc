input = <<EOS
178
135
78
181
137
16
74
11
142
109
148
108
151
184
121
58
110
52
169
128
2
119
38
136
25
26
73
157
153
7
19
160
4
80
10
51
1
131
55
86
87
21
46
88
173
71
64
114
120
167
172
145
130
33
20
190
35
79
162
122
98
177
179
68
48
118
125
192
174
99
152
3
89
105
180
191
61
13
90
129
47
138
67
115
44
59
60
95
93
166
154
101
34
113
139
77
94
161
187
45
22
12
163
41
27
132
30
143
168
144
83
100
102
72
EOS

input  = <<EOS
16
10
15
5
1
11
7
19
6
12
4
EOS

input3 = <<EOS
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
EOS

adapters = input.lines.map(&:to_i)
jolts = ([0] + adapters + [adapters.max + 3]).sort

diffs = jolts.each_cons(2).map { |a, b| b - a }

(1..3).each { |i| p [i, diffs.count(i)] }

part1 = diffs.count(1) * diffs.count(3)

puts part1

chunks = diffs.chunk(&:itself).map { |n, list| [n, list.length] }
p diffs
p chunks.select { |a, b| a == 1 }

part2 = 1
part2 *= 7 ** chunks.count([1, 4])
part2 *= 4 ** chunks.count([1, 3])
part2 *= 2 ** chunks.count([1, 2])
puts part2
