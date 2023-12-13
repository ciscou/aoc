INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

rows_and_groups = INPUT.map do |line|
  row, groups = line.split(" ")
  row = ([row] * 5).join("?")
  groups = ([groups] * 5).join(",")
  { row: row, groups: groups.split(",").map(&:to_i) }
end

def possible_arrangements(row, groups, row_offset, groups_offset, memo)
  memok = [row_offset, groups_offset]
  memod = memo[memok]
  return memod if memod

  if groups_offset == groups.length
    if row[row_offset..].include?("#")
      memo[memok] = 0
      return 0
    else
      memo[memok] = 1
      return 1
    end
  end

  while row_offset < row.length && row[row_offset] == "."
    row_offset += 1
  end

  group = groups[groups_offset]

  # try to skip this question mark
  branch1 = case row[row_offset]
            when "?"
              # row[row_offset] = "."
              res = possible_arrangements(row, groups, row_offset + 1, groups_offset, memo)
              # row[row_offset] = "?"
              res
            else
              0
            end
  # try to add next group right here
  prefix = row[row_offset, group]
  suffix = row[row_offset + group, 1]
  branch2 = case prefix.gsub("?", "#") + (suffix || "").gsub("?", ".")
            when "#" * group # EOS
              # row[row_offset, group] = "#" * group
              res = possible_arrangements(row, groups, row_offset + group, groups_offset + 1, memo)
              # row[row_offset, group] = prefix
              res
            when "#" * group + "."
              # row[row_offset, group] = "#" * group
              # row[row_offset + group, 1] = "."
              res = possible_arrangements(row, groups, row_offset + group + 1, groups_offset + 1, memo)
              # row[row_offset, group] = prefix
              # row[row_offset + group, 1] = suffix
              res
            else
              0
            end

  memo[memok] = branch1 + branch2
  branch1 + branch2
end

part1 = 0
rows_and_groups.each_with_index do |row_and_groups, i|
  start = Time.now
  kk = possible_arrangements(row_and_groups[:row], row_and_groups[:groups], 0, 0, {})
  p [i+1, kk, Time.now - start]
  part1 += kk
end
puts part1
