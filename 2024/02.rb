INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

def safe?(report)
  diffs = report.each_cons(2).map { _2 - _1 }

  (diffs.all?(&:positive?) || diffs.all?(&:negative?)) && diffs.map(&:abs).max <= 3
end

reports = INPUT.map { _1.split.map(&:to_i) }

part1 = reports.count do |report|
  safe?(report)
end
puts part1

part2 = reports.count do |report|
  next true if safe?(report)

  report.length.times.any? do |i|
    report2 = report.dup
    report2.delete_at(i)

    safe?(report2)
  end
end
puts part2
