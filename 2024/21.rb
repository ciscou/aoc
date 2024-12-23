INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

PanicAttack = Class.new(StandardError)

class Keypad
  attr_reader :key

  def left
    move(0, -1)
  end

  def right
    move(0, 1)
  end

  def up
    move(-1, 0)
  end

  def down
    move(1, 0)
  end

  def press(key = nil)
    @key = key unless key.nil?

    if @controls
      case @key
      when "<"
        @controls.left
      when ">"
        @controls.right
      when "^"
        @controls.up
      when "v"
        @controls.down
      when "A"
        @controls.press
      else
        raise "unexpected key #{@key.inspect}"
      end
    else
      @output << @key
    end
  end

  private

  def move(dr, dc)
    r, c = key_pos(@key)
    r += dr
    c += dc
    @key = key_at([r, c])
    raise PanicAttack unless @key
  end
end

class NumKeypad < Keypad
  KEY_POS = {
    "7" => [0, 0],
    "8" => [0, 1],
    "9" => [0, 2],
    "4" => [1, 0],
    "5" => [1, 1],
    "6" => [1, 2],
    "1" => [2, 0],
    "2" => [2, 1],
    "3" => [2, 2],
    nil => [3, 0],
    "0" => [3, 1],
    "A" => [3, 2],
  }

  KEY_AT = KEY_POS.invert

  def initialize
    @key = "A"
    @output = ""
  end

  attr_reader :output

  private

  def key_pos(key)
    KEY_POS[key]
  end

  def key_at(pos)
    KEY_AT[pos]
  end
end

class DirKeypad < Keypad
  KEY_POS = {
    nil => [0, 0],
    "^" => [0, 1],
    "A" => [0, 2],
    "<" => [1, 0],
    "v" => [1, 1],
    ">" => [1, 2],
  }

  KEY_AT = KEY_POS.invert

  def initialize(controls)
    @key = "A"
    @controls = controls
  end

  private

  def key_pos(key)
    KEY_POS[key]
  end

  def key_at(pos)
    KEY_AT[pos]
  end
end

def simulate(keys, n)
  keypads = [NumKeypad.new]
  (n + 1).times do 
    keypads << DirKeypad.new(keypads.last)
  end

  keys.each do |key|
    keypads.last.press(key)
  end

  [
    keypads.first.output,
    keypads.map(&:key),
  ]
end

def bfs(code, n)
  queue = []
  queue << []

  visited = Set.new

  until queue.empty?
    keys = queue.shift

    # p keys.join

    begin
      prefix, current_keys = simulate(keys, n)

      # puts prefix unless [nil, "3", "6", "9", "A"].include?(prefix[0])
      # puts prefix unless prefix == "" || prefix == "A"

      return keys if code == prefix

      next unless code.start_with?(prefix)

      next unless visited.add?([prefix, current_keys])

      # p [code, prefix] unless prefix.empty?
    rescue PanicAttack
      next
    end

    ["A", "<", ">", "^", "v"].each do |key|
      queue << keys + [key]
    end
  end
end

def combinations(keys, depth, key_pos, key_at)
  return [keys] if depth == 0

  prev_key = "A" # TODO: pass a prev_key param to the depth-1 calls?

  first_r_then_c = []
  first_c_then_r = []

  keys.each do |key|
    pr, pc = key_pos[prev_key] # prev position
    cr, cc = key_pos[key]      # curr position

    dr = cr - pr
    dc = cc - pc

    r = [dr < 0 ? "^" : "v"] * dr.abs
    c = [dc < 0 ? "<" : ">"] * dc.abs

    opt1 = r + c + ["A"]
    opt2 = c + r + ["A"]

    combinations(opt1, depth - 1, DirKeypad::KEY_POS, DirKeypad::KEY_AT).each do |comb|
      first_r_then_c << comb
    end

    combinations(opt2, depth - 1, DirKeypad::KEY_POS, DirKeypad::KEY_AT).each do |comb|
      first_c_then_r << comb
    end

    prev_key = key
    # puts "#{"  " * depth} #{prev_key.inspect}"
  end

  ans = []

  zip = first_r_then_c.zip(first_c_then_r)
  zip.map!(&:uniq)
  z, *ip = zip
  z.product(*ip) do |a|
    ans << a.flatten
  end

  puts "zip thingie"
  puts "first_r_then_c"
  p first_r_then_c
  puts "first_c_then_r"
  p first_c_then_r
  puts "ans"
  p ans
  gets

  ans
end

codes = INPUT

part1 = 0
codes.each do |code|
  combinations(code.chars, 3, NumKeypad::KEY_POS, NumKeypad::KEY_AT).sort_by(&:length).each do |comb|
    simulate(comb, 2)
    part1 += code.to_i * comb.length
    # break
  rescue PanicAttack
    # next
  end
  puts
end
puts part1

exit

part1 = 0
codes.each do |code|
  keys = bfs(code, 0)
  p keys.join
  part1 += code.to_i * keys.length
end
puts part1

exit

part2 = 0
codes.each do |code|
  keys = bfs(code, 25)
  p keys.join
  part2 += code.to_i * keys.length
end
puts part2
