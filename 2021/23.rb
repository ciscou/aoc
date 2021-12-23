INPUT = File.read(ARGV.first || __FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

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

class Amphipods
  ROOM_FOR_AMPHIPOD = {
    "A" => 3,
    "B" => 5,
    "C" => 7,
    "D" => 9
  }

  ENERGY_PER_STEP_FOR_AMPHIPOD = {
    "A" => 1,
    "B" => 10,
    "C" => 100,
    "D" => 1000
  }

  def initialize
    @cells = INPUT.map(&:chars)

    @amphipods = []
    @cells.length.times do |row|
      @cells[row].length.times do |col|
        if ("A".."Z").include?(@cells[row][col])
          @amphipods.push({ type: @cells[row][col], row: row, col: col })
        end
      end
    end
  end

  def print
    puts @cells.map(&:join)
    puts

    @amphipods.each do |amphipod|
      position = if is_in_hallway?(amphipod)
                   "hallway"
                 elsif is_in_its_own_room?(amphipod)
                   "its own room"
                 elsif is_in_another_room?(amphipod)
                   "another room"
                 else
                   raise "Invalid position for amphipod #{amphipod.inspect}"
                 end

      puts "amphipod #{amphipod[:type]} is in #{position}"
    end
  end

  def set_state(state)
    @cells.length.times do |row|
      @cells[row].length.times do |col|
        @cells[row][col] = "." if ("A".."Z").include?(@cells[row][col])
      end
    end

    state.each do |amphipod|
      @cells[amphipod[:row]][amphipod[:col]] = amphipod[:type]
    end

    @amphipods = state

    self
  end

  def solve
    initial_state = @amphipods.map(&:dup)

    queue = PriorityQueue.new
    queue << { state: initial_state, total_energy: 0, priority: 0 }

    visited = Hash.new(Float::INFINITY)
    visited[hashify_state(initial_state)] = 0

    loop do
      node = queue.pop
      break if node.nil?

      state = node[:state]
      total_energy = node[:total_energy]

      if state.all? { |a| is_in_its_own_room?(a) }
        return total_energy
      end

      candidate_next_states_from(state.map(&:dup)).sort_by(&:last).each do |next_state, energy|
        next if visited[hashify_state(next_state)] <= total_energy + energy
        visited[hashify_state(next_state)] = total_energy + energy

        queue << { state: next_state.map(&:dup), total_energy: total_energy + energy, priority: -(total_energy + energy + heuristic(next_state)) }
      end
    end

    nil
  end

  private

  def heuristic(next_state)
    h = 0

    next_state.each do |amphipod|
      if is_in_hallway?(amphipod)
        h += (1 + (amphipod[:col] - ROOM_FOR_AMPHIPOD[amphipod[:type]]).abs) * ENERGY_PER_STEP_FOR_AMPHIPOD[amphipod[:type]]
      elsif is_in_another_room?(amphipod)
        h += (amphipod[:row] - 1 + (amphipod[:col] - ROOM_FOR_AMPHIPOD[amphipod[:type]]).abs) * ENERGY_PER_STEP_FOR_AMPHIPOD[amphipod[:type]]
      end
    end

    h
  end

  def hashify_state(state)
    hash = []

    hash << state.select { |a| a[:type] == "A" }.map { |a| [a[:row], a[:col]] }.sort
    hash << state.select { |a| a[:type] == "B" }.map { |a| [a[:row], a[:col]] }.sort
    hash << state.select { |a| a[:type] == "C" }.map { |a| [a[:row], a[:col]] }.sort
    hash << state.select { |a| a[:type] == "D" }.map { |a| [a[:row], a[:col]] }.sort

    hash
  end

  def candidate_next_states_from(state)
    next_states = []

    amphipods_by_position = Hash.new { |h, k| h[k] = [] }
    amphipods_by_position.merge!(state.group_by { |a| [a[:row], a[:col]] })

    state.each_with_index do |amphipod, i|
      unless is_in_its_own_room?(amphipod)
        # go to its own room
        room_col = ROOM_FOR_AMPHIPOD[amphipod[:type]]

        # go only if there are no amphipods of another type there
        if (2..5).all? { |room_row| amphipods_by_position[[room_row, room_col]].all? { |a| a[:type] == amphipod[:type] } }
          next_states_ending_at_home = []

          (2..5).each do |room_row|
            path = calculate_path([amphipod[:row], amphipod[:col]], [room_row, room_col])

            # Do not run over other amphipods
            if path.all? { |pos| amphipods_by_position[pos].empty? }
              next_state = state.map(&:dup)

              next_state[i][:row] = room_row
              next_state[i][:col] = room_col
              next_states_ending_at_home << [next_state, ENERGY_PER_STEP_FOR_AMPHIPOD[amphipod[:type]] * path.length]
            end
          end

          # go to the bottom of the room
          next_states << next_states_ending_at_home.last unless next_states_ending_at_home.empty?
        end
      end

      # puts "before"
      # puts next_states.map(&:first).map(&:inspect)
      # puts

      if is_in_another_room?(amphipod) || is_in_its_own_room_but_not_at_the_bottom?(amphipod)
        # go to the hallway
        hallway_row = 1

        [1, 2, 4, 6, 8, 10, 11].each do |hallway_col|
          path = calculate_path([amphipod[:row], amphipod[:col]], [hallway_row, hallway_col])

          # Do not run over other amphipods
          if path.all? { |pos| amphipods_by_position[pos].empty? }
            next_state = state.map(&:dup)

            next_state[i][:row] = hallway_row
            next_state[i][:col] = hallway_col

            next_states << [next_state, ENERGY_PER_STEP_FOR_AMPHIPOD[amphipod[:type]] * path.length]
          end
        end
      end

      # puts "after"
      # puts next_states.map(&:first).map(&:inspect)
      # $stdin.gets
    end

    # me_interesa = next_states.map(&:first).select { |s| s.include?({ type: "A", row: 1, col: 10 }) }
    # me_interesa.each do |me_interesa_state|
    #   puts 1
    #   puts(me_interesa_state - state).inspect
    #   puts 2
    #   puts(state - me_interesa_state).inspect
    # end
    # puts "yata"
    # $stdin.gets

    # next_states.each do |next_state, energy|
    #   if state[1..-1].all? { |a| is_in_its_own_room?(a) }
    #     puts energy
    #     puts next_state.map(&:inspect)
    #     puts next_state.all? { |a| is_in_its_own_room?(a) }
    #     $stdin.gets
    #   end
    # end

    next_states
  end

  def calculate_path(from, to)
    row1, col1 = from
    row2, col2 = to

    path = []

    # TODO: move inside room, to the bottom???

    while row1 > 1
      row1 -= 1
      path << [row1, col1]
    end

    while col1 < col2
      col1 += 1
      path << [row1, col1]
    end

    while col1 > col2
      col1 -= 1
      path << [row1, col1]
    end

    while row1 < row2
      row1 += 1
      path << [row1, col1]
    end

    path
  end

  def is_in_hallway?(amphipod)
    amphipod[:row] == 1
  end

  def is_in_room?(amphipod)
    amphipod[:row] > 1
  end

  def is_in_its_own_room?(amphipod)
    is_in_room?(amphipod) && amphipod[:col] == ROOM_FOR_AMPHIPOD[amphipod[:type]]
  end

  def is_in_its_own_room_but_not_at_the_bottom?(amphipod)
    is_in_its_own_room?(amphipod) && amphipod[:row] < 5
  end

  def is_in_another_room?(amphipod)
    is_in_room?(amphipod) && amphipod[:col] != ROOM_FOR_AMPHIPOD[amphipod[:type]]
  end
end

amphipods = Amphipods.new

puts "Part 1: #{amphipods.solve.inspect}"
