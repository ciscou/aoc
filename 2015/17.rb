input = <<EOS
43
3
4
10
21
44
4
6
47
41
34
17
17
44
36
31
46
9
27
38
EOS

containers = input.lines.map(&:to_i)

res = []

(1..containers.length).each do |a|
  containers.combination(a).each do |cs|
    res << cs if cs.sum == 150
  end
end

puts res.map(&:inspect)
puts res.length

optimal = res.map(&:length).min

puts res.select { |r| r.length == optimal }.length
