require_relative "../shared/utils"

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = INPUT.map(&:chars)

pos = nil
target = nil

grid.each_with_index do |row, r|
  row.each_with_index do |cell, c|
    if cell == "S"
      pos = [r, c]
      row[c] = "a"
    end
    if cell == "E"
      target = [r, c]
      row[c] = "z"
    end
  end
end

class MyUpwardsBFS < GridBFS
  private

  def can_move?(from, to)
    to.ord - from.ord <= 1
  end
end

class MyDownwardsBFS < GridBFS
  private

  def can_move?(from, to)
    from.ord - to.ord <= 1
  end
end

MyUpwardsBFS.new(grid, pos[0], pos[1]).execute.each do |row, col, path|
  if row == target[0] && col == target[1]
    puts path.length
    break
  end
end

MyDownwardsBFS.new(grid, target[0], target[1]).execute.each do |row, col, path|
  if grid[row][col] == "a"
    puts path.length
    break
  end
end
