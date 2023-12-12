INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

rows_and_groups = INPUT.map do |line|
  row, groups = line.split(" ")
  { row: row, groups: groups.split(",").map(&:to_i) }
end

def possible_arrangements(row, groups)
  orig_row = row
  orig_groups = groups

  return 1 if groups.empty? # TODO: make sure there are no ? in row? make sure row matches original groups?

  while !row.empty? && !row.start_with?("?") && !row.start_with?("#")
    row = row[1..-1]
  end

  return 0 unless row.start_with?("?") || row.start_with?("#") # TODO: redundant with condition below?

  group = groups.first

  branch1 = case row[0]
            when "?"
              possible_arrangements(row[1..-1], groups)
            else
              0
            end
  branch2 = case row[0, group].gsub("?", "#") + (row[group, 1] || "").gsub("?", ".")
            when "#" * group # EOS
              possible_arrangements("", groups[1..-1])
            when "#" * group + "."
              possible_arrangements(row[(group + 1)..-1], groups[1..-1])
            else
              0
            end

  branch1 + branch2
end

part1 = 0
rows_and_groups.each do |row_and_groups|
  kk = possible_arrangements(row_and_groups[:row], row_and_groups[:groups])
  p row_and_groups
  puts kk
  gets
  part1 += kk
end
puts part1
