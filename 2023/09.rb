INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

seqs = INPUT.map { [_1.split.map(&:to_i)] }

seqs.each do |seq|
  until seq.last.all? { _1 == 0 }
    seq << seq.last.each_cons(2).map { _2 - _1 }
  end
end

part1 = seqs.map do |seq|
  seq.map(&:last).reverse.inject(0) { _2 + _1 }
end.sum
puts part1

part2 = seqs.map do |seq|
  seq.map(&:first).reverse.inject(0) { _2 - _1 }
end.sum
puts part2
