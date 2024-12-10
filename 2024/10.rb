INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = INPUT.map { |line| line.chars.map { _1 == "." ? -1 : _1.to_i } }

part1 = 0
grid.each_with_index do |row, trailhead_row|
  row.each_with_index do |cell, trailhead_col|
    if cell == 0
      nines = Set.new
      stack = []
      stack << [trailhead_row, trailhead_col]
      until stack.empty?
        curr_row, curr_col = stack.pop
        if grid[curr_row][curr_col] == 9
          nines.add [[curr_row, curr_col]]
        else
          [
            [-1, 0],
            [1, 0],
            [0, 1],
            [0, -1]
          ].each do |dc, dr|
            next_row = curr_row + dr
            next_col = curr_col + dc
            next if next_row < 0
            next if next_col < 0
            next unless next_row < grid.length
            next unless next_col < grid[next_row].length
            next unless grid[curr_row][curr_col] + 1 == grid[next_row][next_col]
            stack << [next_row, next_col]
          end
        end
      end
      part1 += nines.length
    end
  end
end
puts part1
