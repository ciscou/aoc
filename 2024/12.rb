INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = INPUT.map(&:chars)

def dfs(grid, garden, gardens_by_pos, r, c)
  return true if gardens_by_pos[[r, c]] == garden

  return if r < 0
  return if c < 0
  return unless r < grid.length
  return unless c < grid[r].length

  return unless grid[r][c] == garden[:letter]

  return if gardens_by_pos.key?([r, c])

  gardens_by_pos[[r, c]] = garden
  garden[:area] += 1

  garden[:perimeter] += 1 unless dfs(grid, garden, gardens_by_pos, r-1, c)
  garden[:perimeter] += 1 unless dfs(grid, garden, gardens_by_pos, r+1, c)
  garden[:perimeter] += 1 unless dfs(grid, garden, gardens_by_pos, r, c-1)
  garden[:perimeter] += 1 unless dfs(grid, garden, gardens_by_pos, r, c+1)

  true
end

gardens_by_pos = {}
gardens = []

grid.each_with_index do |row, r|
  row.each_with_index do |cell, c|
    next if gardens_by_pos[[r][c]]

    gardens << { letter: cell, area: 0, perimeter: 0 }

    dfs(grid, gardens.last, gardens_by_pos, r, c)
  end
end

part1 = gardens.sum { _1[:area] * _1[:perimeter] }
puts part1
