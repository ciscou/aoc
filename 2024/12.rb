INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

grid = INPUT.map(&:chars)

def dfs(grid, garden, gardens_by_pos, r, c)
  return if r < 0
  return if c < 0
  return unless r < grid.length
  return unless c < grid[r].length
  return unless grid[r][c] == garden[:letter]
  return if gardens_by_pos.key?([r, c])

  gardens_by_pos[[r, c]] = garden
  garden[:area] += 1

  dfs(grid, garden, gardens_by_pos, r-1, c)
  dfs(grid, garden, gardens_by_pos, r+1, c)
  dfs(grid, garden, gardens_by_pos, r, c-1)
  dfs(grid, garden, gardens_by_pos, r, c+1)
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

grid.length.times do |r|
  last_garden = nil
  grid[r].length.times do |c|
    garden = gardens_by_pos[[r, c]]
    if last_garden.nil? || last_garden[:letter] != garden[:letter]
      last_garden[:perimeter] += 1 unless last_garden.nil?
      garden[:perimeter] += 1
      last_garden = garden
    end
  end
  last_garden[:perimeter] += 1
end

grid.first.length.times do |c|
  last_garden = nil
  grid.length.times do |r|
    garden = gardens_by_pos[[r, c]]
    if last_garden.nil? || last_garden[:letter] != garden[:letter]
      last_garden[:perimeter] += 1 unless last_garden.nil?
      garden[:perimeter] += 1
      last_garden = garden
    end
  end
  last_garden[:perimeter] += 1
end

part1 = gardens.sum { _1[:area] * _1[:perimeter] }
puts part1
