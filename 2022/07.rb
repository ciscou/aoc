INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

class AoCDirectory
  def initialize
    @entries = {}
  end

  def dfs
    return [self] + @entries.values.flat_map(&:dfs)
  end

  def size
    @size ||= calculate_size
  end

  def directory(name)
    @entries[name] ||= AoCDirectory.new
  end

  def file(name, size)
    @entries[name] ||= AoCFile.new(size)
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

  def dfs
    []
  end

  attr_reader :size
end

root = nil
pwd = []

COMMANDS = INPUT.chunk_while { |l1, l2| !l2.start_with?("$") }

COMMANDS.each do |command|
  input, *output = command
  _dollar, cmd, *args = input.split

  case cmd
  when "cd"
    case args
    when ["/"]
      root = AoCDirectory.new
      pwd.push(root)
    when [".."]
      pwd.pop
    else
      directory = pwd.last.directory(args.last)
      pwd.push(directory)
    end
  when "ls"
    output.each do |line|
      unless line.start_with?("dir ")
        size, name = line.split
        pwd.last.file(name, size.to_i)
      end
    end
  end
end

all_dirs = root.dfs

puts all_dirs.map(&:size).select { |size| size <= 100000 }.sum

disk_size = 70000000
update_needs = 30000000
available_space = disk_size - root.size
needs_to_free = update_needs - available_space

puts all_dirs.map(&:size).select { |size| size >= needs_to_free }.min
