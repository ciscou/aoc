input = <<EOS
Faerun to Norrath = 129
Faerun to Tristram = 58
Faerun to AlphaCentauri = 13
Faerun to Arbre = 24
Faerun to Snowdin = 60
Faerun to Tambi = 71
Faerun to Straylight = 67
Norrath to Tristram = 142
Norrath to AlphaCentauri = 15
Norrath to Arbre = 135
Norrath to Snowdin = 75
Norrath to Tambi = 82
Norrath to Straylight = 54
Tristram to AlphaCentauri = 118
Tristram to Arbre = 122
Tristram to Snowdin = 103
Tristram to Tambi = 49
Tristram to Straylight = 97
AlphaCentauri to Arbre = 116
AlphaCentauri to Snowdin = 12
AlphaCentauri to Tambi = 18
AlphaCentauri to Straylight = 91
Arbre to Snowdin = 129
Arbre to Tambi = 53
Arbre to Straylight = 40
Snowdin to Tambi = 15
Snowdin to Straylight = 99
Tambi to Straylight = 70
EOS

distances = Hash.new { |h, k| h[k] = {} }
countries = []

input.lines.each do |line|
  line.chomp!

  case line
  when /^(\w+) to (\w+) = (\d+)$/
    distances[$1][$2] = $3.to_i

    countries << $1
    countries << $2
  else
    raise "cannot match #{line.inspect}"
  end
end

countries.sort!.uniq!

shortest_route = 999_999_999_999
longest_route = 0

countries.permutation.each do |cs|
  distance = 0

  cs.each_cons(2).each do |c1, c2|
    d = distances[c1][c2] || distances[c2][c1]
    distance += d
  end

  shortest_route = distance if distance < shortest_route
  longest_route = distance if distance > longest_route
end

puts "shortest route: #{shortest_route}"
puts "longest route: #{longest_route}"
