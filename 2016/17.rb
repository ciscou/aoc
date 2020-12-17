require "digest"

$input = "rrrbmfta"

$available_moves = {
  "U" => [-1,  0],
  "D" => [ 1,  0],
  "L" => [ 0, -1],
  "R" => [ 0,  1]
}

def valid_move?(visited, path, row, col)
  return false if row < 0
  return false if col < 0
  return false if row > 3
  return false if col > 3

  return false if visited[path][row][col]

  true
end

def open_door?(path, mov)
  md5 = Digest::MD5.hexdigest("#{$input}#{path}")
  ("b".."f").include? md5[$available_moves.keys.index(mov)]
end

def bfs()
  res = []
  visited = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = {} } }
  queue = []

  visited[0][0] = true
  queue.push([0, 0, ""])

  min_path = nil

  until queue.empty?
    node = queue.shift()

    row, col, path = node

    if row == 3 && col == 3
      res << path
    else
      $available_moves.each do |mov, dpos|
        drow, dcol = dpos

        if open_door?(path, mov) && valid_move?(visited, path, row + drow, col + dcol)
          visited[path][row + drow][col + dcol] = true
          queue.push([row + drow, col + dcol, path + mov])
        end
      end
    end
  end

  res
end

res = bfs().sort_by(&:length).last
if res
  puts res
  puts res.length
else
  puts "no solution found!"
end
