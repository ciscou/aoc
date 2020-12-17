input = <<EOS
336, 308
262, 98
352, 115
225, 205
292, 185
166, 271
251, 67
266, 274
326, 85
191, 256
62, 171
333, 123
160, 131
211, 214
287, 333
231, 288
237, 183
211, 272
116, 153
336, 70
291, 117
156, 105
261, 119
216, 171
59, 343
50, 180
251, 268
169, 258
75, 136
305, 102
154, 327
187, 297
270, 225
190, 185
339, 264
103, 301
90, 92
164, 144
108, 140
189, 211
125, 157
77, 226
177, 168
46, 188
216, 244
346, 348
272, 90
140, 176
109, 324
128, 132
EOS

# input = <<EOS
# 1, 1
# 1, 6
# 8, 3
# 3, 4
# 5, 5
# 8, 9
# EOS

coordinates = input.lines.map do |line|
  line.chomp!

  line.split(", ").map(&:to_i)
end

areas1 = Hash.new(0)
areas2 = Hash.new(0)

borders = {}

(-1000..1000).each do |x|
  (-1000..1000).each do |y|
    cs = coordinates.map { |c| [(c.first - x).abs + (c.last - y).abs, c] }.sort_by!(&:first)
    if cs[0].first < cs[1].first
      areas1[[cs[0].last.first, cs[0].last.last]] += 1
      if x == -1000 || x == 1000 || y == -1000 || y == 1000
        borders[cs[0].last] = true
      end
    end

    coordinates.each do |c|
      cx, cy = c
      areas2[[x, y]] += (cx - x).abs + (cy - y).abs
    end
  end
end

p borders
areas1.reject { |k, v| borders[k] }.sort_by(&:last).each { |a| p a.reverse }
puts areas2.select { |k, v| v < 10_000 }.length
