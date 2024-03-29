INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

DEPTH = INPUT.first.split(" ").last.to_i
TARGET_X = INPUT.last.split(" ").last.split(",").first.to_i
TARGET_Y = INPUT.last.split(" ").last.split(",").last.to_i

GEOLOGICAL_INDEX_CACHE = {}
GEOLOGICAL_INDEX_CACHE[[0, 0]] = 0
GEOLOGICAL_INDEX_CACHE[[TARGET_X, TARGET_Y]] = 0

# stolen from https://gist.github.com/brianstorti/e20300eb2e7d62b87849
class PriorityQueue
  attr_reader :elements

  def initialize
    @elements = [nil]
  end

  def <<(element)
    @elements << element
    bubble_up(@elements.size - 1)
  end

  alias_method :push, :<<

  def pop
    exchange(1, @elements.size - 1)
    max = @elements.pop
    bubble_down(1)
    max
  end

  private

  def bubble_up(index)
    parent_index = (index / 2)

    return if index <= 1
    return if @elements[parent_index][:priority] >= @elements[index][:priority]

    exchange(index, parent_index)
    bubble_up(parent_index)
  end

  def bubble_down(index)
    child_index = (index * 2)

    return if child_index > @elements.size - 1

    not_the_last_element = child_index < @elements.size - 1
    left_element = @elements[child_index]
    right_element = @elements[child_index + 1]
    child_index += 1 if not_the_last_element && right_element[:priority] > left_element[:priority]

    return if @elements[index][:priority] >= @elements[child_index][:priority]

    exchange(index, child_index)
    bubble_down(child_index)
  end

  def exchange(source, target)
    @elements[source], @elements[target] = @elements[target], @elements[source]
  end
end

def geological_index(pos)
  return GEOLOGICAL_INDEX_CACHE[pos] if GEOLOGICAL_INDEX_CACHE.key?(pos)

  x, y = pos
  GEOLOGICAL_INDEX_CACHE[pos] = if y == 0
                                   x * 16807
                                 elsif x == 0
                                   y * 48271
                                 else
                                   erosion_level([x-1, y]) * erosion_level([x, y-1])
                                 end
end

def erosion_level(pos)
  (geological_index(pos) + DEPTH) % 20183
end

def type(pos)
  case erosion_level(pos) % 3
  when 0 then "rocky"
  when 1 then "wet"
  when 2 then "narrow"
  else raise
  end
end

def candidate_moves
  [
    [ 0, -1],
    [ 0,  1],
    [-1,  0],
    [ 1,  0],
    "climbing_gear",
    "torch",
    "neither"
  ]
end

def valid_position?(pos)
  x, y, equip = pos

  return false if x < 0 || y < 0

  case type([pos[0], pos[1]])
  when "rocky"
    return false if equip == "neither"
  when "wet"
    return false if equip == "torch"
  when "narrow"
    return false if equip == "climbing_gear"
  else raise "invalid equip #{equip.inspect}"
  end

  true
end

def a_star
  open = PriorityQueue.new
  closed = Hash.new(Float::INFINITY)

  initial = { pos: [0, 0, "torch"], total_time: 0, priority: -(TARGET_X + TARGET_Y) }
  open.push(initial)
  closed[initial[:pos]] = initial[:total_time]

  loop do
    node = open.pop
    break if node.nil?

    pos = node[:pos]
    total_time = node[:total_time]
    x, y, equip = pos

    if y == TARGET_Y && x == TARGET_X && equip == "torch"
      return node
    end

    next if total_time > closed[node[:pos]]

    candidate_moves.each do |move|
      elapsed = 0
      dx, dy = 0, 0
      dequip = equip

      if move.is_a?(String)
        dequip = move
        elapsed = 7
        next if dequip == equip
      else
        elapsed = 1
        dx, dy = move
      end

      manhattan = (TARGET_X - (x + dx)).abs + (TARGET_Y - (y + dy)).abs
      next_node = { pos: [x + dx, y + dy, dequip], total_time: total_time + elapsed, priority: -(total_time + elapsed + manhattan) }

      next unless valid_position?(next_node[:pos])

      if next_node[:total_time] < closed[next_node[:pos]]
        closed[next_node[:pos]] = next_node[:total_time]

        open.push(next_node)
      end
    end
  end

  nil # no solution
end

risk_level = 0

(0..TARGET_Y).each do |y|
  (0..TARGET_X).each do |x|
    risk_level += erosion_level([x, y]) % 3
  end
end

puts risk_level

puts a_star
