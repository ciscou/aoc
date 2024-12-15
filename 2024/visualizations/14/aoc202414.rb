require 'ruby2d'

# Define constants
INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

WIDTH = 101
HEIGHT = 103
CELL_SIZE = 6

set title: "Advent of Code 2024 14", width: WIDTH * CELL_SIZE, height: HEIGHT * CELL_SIZE

grid = Array.new(HEIGHT) { Array.new(WIDTH, false) }

robots = INPUT.map do |line|
  p, v = line.split(" ")
  x, y = p.split("=").last.split(",").map(&:to_i)
  vx, vy = v.split("=").last.split(",").map(&:to_i)

  {
    x:,
    y:,
    vx:,
    vy:,
  }
end

elapsed = 7601 * 100
running = false

def draw_grid(grid)
  HEIGHT.times do |y|
    WIDTH.times do |x|
      if grid[y][x]
        Square.new(x: x * CELL_SIZE, y: y * CELL_SIZE, size: CELL_SIZE, color: 'green', opacity: 0.8)
      end
    end
  end
end

def update_grid(grid, robots, elapsed)
  HEIGHT.times do |y|
    WIDTH.times do |x|
      grid[y][x] = false
    end
  end

  robots.each do |robot|
    x = (robot[:x] + robot[:vx] * elapsed / 100) % WIDTH
    y = (robot[:y] + robot[:vy] * elapsed / 100) % HEIGHT

    grid[y][x] = true
  end
end

# Main draw loop
update do
  clear
  update_grid(grid, robots, elapsed)
  draw_grid(grid)
  if running
    elapsed += 1
    puts elapsed
  end
  # puts elapsed
end

on :key_down do |event|
  case event.key
  when "space"
    running = !running
  when "r"
    running = false
    elapsed = 7601 * 100
  when "left"
    running = false
    elapsed -= 1
    puts elapsed
  when "right"
    running = false
    elapsed += 1
    puts elapsed
  end
end

show
