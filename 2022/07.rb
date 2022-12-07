INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class AoCDirectory
  def initialize
    @entries = {}
  end

  def size
    @size ||= calculate_size
  end

  def mkdir(name)
    @entries[name] = AoCDirectory.new
  end

  def touch(name, size)
    @entries[name] = AoCFile.new(size)
  end

  private

  def calculate_size
    @entries.values.sum(&:size)
  end
end

class AoCFile
  def initialize(size)
    @size = size
  end

  attr_reader :size
end

root = nil
path = []
all_dirs = []

COMMANDS = INPUT.chunk_while { |l1, l2| !l2.start_with?("$") }

COMMANDS.each do |command|
  input, *output = command
  _dollar, cmd, arg = input.split

  pwd = path.last

  case cmd
  when "cd"
    case arg
    when "/"
      root = AoCDirectory.new
      path.push(root)
      all_dirs.push(root)
    when ".."
      path.pop
    else
      dir = pwd.mkdir(arg)
      path.push(dir)
      all_dirs.push(dir)
    end
  when "ls"
    output.each do |line|
      unless line.start_with?("dir ")
        size, name = line.split
        pwd.touch(name, size.to_i)
      end
    end
  end
end

puts all_dirs.map(&:size).select { |size| size <= 100_000 }.sum

disk_size = 70_000_000
update_needs = 30_000_000
available_space = disk_size - root.size
needs_to_free = update_needs - available_space

puts all_dirs.map(&:size).select { |size| size >= needs_to_free }.min
