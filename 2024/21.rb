INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

PanicAttack = Class.new(StandardError)

class Keypad
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
    raise PanickAttack unless @key
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

seqs = [
  "<vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A",
  "<v<A>>^AAAvA^A<vA<AA>>^AvAA<^A>A<v<A>A>^AAAvA<^A>A<vA>^A<A>A",
  "<v<A>>^A<vA<A>>^AAvAA<^A>A<v<A>>^AAvA^A<vA>^AA<A>A<v<A>A>^AAAvA<^A>A",
  "<v<A>>^AA<vA<A>>^AAvAA<^A>A<vA>^A<A>A<vA>^A<A>A<v<A>A>^AAvA<^A>A",
  "<v<A>>^AvA^A<vA<AA>>^AAvA<^A>AAvA^A<vA>^AA<A>A<v<A>A>^AAAvA<^A>A",
]

seqs.each do |seq|
  num_keypad = NumKeypad.new
  dir_keypad_1 = DirKeypad.new(num_keypad)
  dir_keypad_2 = DirKeypad.new(dir_keypad_1)
  dir_keypad_3 = DirKeypad.new(dir_keypad_2)

  seq.chars.each do |key|
    dir_keypad_3.press(key)
  end
  puts num_keypad.output
end
