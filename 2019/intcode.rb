class Intcode
  def initialize(source)
    @program = {}
    source.split(",").map(&:to_i).each_with_index do |x, i|
      @program[i] = x
    end
    @program.default = 0

    @pc = 0
    @relative_base = 0
  end

  attr_reader :program

  def input
    gets.to_i
  end

  def output(val)
    puts(val)
  end

  def halt?
    @program[@pc] == 99
  end

  def run
    until halt?
      tick
    end
  end

  def tick
    unless halt?
      read_instruction

      case @o
      when 1
        @program[@z] = @x + @y
        @pc += 4
      when 2
        @program[@z] = @x * @y
        @pc += 4
      when 3
        val = input
        if val
          @program[@x] = val
          @pc += 2
        end
      when 4
        output @x
        @pc += 2
      when 5
        if @x == 0
          @pc += 3
        else
          @pc = @y
        end
      when 6
        if @x == 0
          @pc = @y
        else
          @pc += 3
        end
      when 7
        if @x < @y
          @program[@z] = 1
        else
          @program[@z] = 0
        end
        @pc += 4
      when 8
        if @x == @y
          @program[@z] = 1
        else
          @program[@z] = 0
        end
        @pc += 4
      when 9
        @relative_base += @x
        @pc += 2
      when 99
        # no-op
      else
        raise "OMG"
      end
    end
  end

  private

  def read_instruction
    @o, @x, @y, @z = 4.times.map { |i| @program[@pc + i] }

    abc, @o = @o.divmod(100)
    ab, c = abc.divmod(10)
    a, b = ab.divmod(10)

    if @o == 3
      @x = @x + @relative_base if c == 2
    else
      @x = @program[@x + @relative_base] if c == 2
      @y = @program[@y + @relative_base] if b == 2
      @z = @z + @relative_base if a == 2

      @x = @program[@x] if c == 0
      @y = @program[@y] if b == 0
    end
  end
end
