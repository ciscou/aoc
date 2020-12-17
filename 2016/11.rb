def initial_config
  floors = [
    [[], []],
    [%w[polonium thulium promethium ruthenium cobalt], %w[thulium ruthenium cobalt]],
    [[],%w[polonium promethium]],
    [[], []],
    [[], []],
    [[], []]
  ]

  {
    floors: floors,
    elevator: 1
  }
end

def display_config(config)
  floors = config[:floors]
  elevator = config[:elevator]

  [4, 3, 2, 1].each do |i|
    floor = floors[i]
    generators, microchips = floor
    puts "F#{i} - #{elevator == i ? "E" : "."} - #{generators.inspect} - #{microchips.inspect}"
  end
end

def move_config(config, dir, generators, microchips)
  floors = config[:floors]
  elevator = config[:elevator]
  floor = floors[elevator]

  all_generators = generators.all? { |g| floor.first.include?(g) }
  all_microchips = microchips.all? { |m| floor.last.include?(m) }
  valid_items    = [1, 2].include?((generators + microchips).length)

  if all_generators && all_microchips && valid_items
    floor[0] -= generators
    floor[1] -= microchips

    config[:elevator] += dir

    floor = floors[config[:elevator]]
    floor[0] += generators
    floor[1] += microchips
  else
    false
  end
end

def valid_config?(config)
  elevator = config[:elevator]

  0 < elevator && elevator < 5
end

def safe_config?(config)
  floors = config[:floors]
  elevator = config[:elevator]
  generators, microchips = floors[elevator]

  generators.empty? || microchips.all? { |m| generators.include?(m) }
end

def solved_config?(config)
  floors = config[:floors]
  elevator = config[:elevator]

  (elevator == 4) && (1..3).all? do |floor|
    floors[floor].all?(&:empty?)
  end
end

def hashify_config(config)
  floors = config[:floors]
  elevator = config[:elevator]

  hashified_floors = floors.map do |floor|
    floor.map(&:sort).map { |ary| ary.join(",") }.join(";")
  end.join("|")

  [elevator, hashified_floors].join("#")
end

def solve_config(config)
  visited = {}
  queue = []

  visited[hashify_config(config)] = true
  queue.push([])

  best_solution = nil

  until queue.empty?
    node = queue.shift()

    config = initial_config()
    node.each do |dir, generators, microchips|
      move_config(config, dir, generators, microchips) || raise("uh oh...")
    end

    if solved_config?(config)
      best_solution = node
      break
    end

    floors = config[:floors]
    elevator = config[:elevator]
    floor = floors[elevator]

    [1, -1].each do |dir|
      3.times do |ngenerators|
        3.times do |nmicrochips|
          nitems = ngenerators + nmicrochips
          next unless 0 < nitems && nitems < 3

          floor.first.combination(ngenerators).each do |generators|
            floor.last.combination(nmicrochips).each do |microchips|
              if move_config(config, dir, generators, microchips)
                if !visited[hashify_config(config)] && valid_config?(config) && safe_config?(config)
                  new_node = node.dup.push([dir, generators, microchips])
                  visited[hashify_config(config)] = true
                  queue.push(new_node)
                end
                move_config(config, -dir, generators, microchips) || raise("uh oh")
              end
            end
          end
        end
      end
    end

    # puts "visited"
    # puts visited.size
    # puts "queue"
    # puts queue.size
    # puts
  end

  best_solution
end

# solution = solve_config(initial_config)
# p solution

solution = [
  [1, [], ["thulium", "ruthenium"]],
  [1, [], ["polonium", "promethium"]],
  [1, [], ["polonium", "promethium"]],
  [-1, [], ["polonium"]],
  [-1, [], ["polonium"]],
  [1, [], ["thulium", "ruthenium"]],
  [1, [], ["thulium", "ruthenium"]],
  [-1, [], ["promethium"]],
  [-1, [], ["promethium"]],
  [1, [], ["polonium", "promethium"]],
  [-1, [], ["polonium"]],
  [-1, [], ["polonium"]],
  [1, [], ["cobalt", "polonium"]],
  [1, [], ["cobalt", "polonium"]],
  [-1, [], ["promethium"]],
  [-1, [], ["promethium"]],
  [1, ["promethium"], ["promethium"]],
  [-1, ["promethium"], []],
  [1, ["polonium", "promethium"], []],
  [-1, ["polonium"], []],
  [1, ["thulium", "ruthenium"], []],
  [-1, ["promethium"], []],
  [1, ["cobalt", "promethium"], []],
  [-1, ["thulium"], []],
  [1, ["polonium", "thulium"], []],
  [1, ["cobalt", "polonium"], []],
  [-1, ["cobalt"], []],
  [1, ["ruthenium", "cobalt"], []],
  [-1, ["polonium"], []],
  [1, ["promethium", "polonium"], []],
  [-1, ["promethium"], []],
  [1, ["promethium"], ["promethium"]],
  [-1, ["ruthenium"], []],
  [1, ["thulium", "ruthenium"], []],
  [1, ["thulium", "ruthenium"], []],
  [-1, ["thulium"], []],
  [1, ["cobalt", "thulium"], []],
  [-1, ["cobalt"], []],
  [1, ["polonium"], ["polonium"]],
  [-1, ["ruthenium"], []],
  [1, ["promethium", "ruthenium"], []],
  [-1, ["promethium"], []],
  [1, ["cobalt"], ["cobalt"]],
  [-1, ["thulium"], []],
  [1, ["promethium", "thulium"], []],
  [-1, [], ["thulium"]],
  [1, [], ["promethium", "thulium"]]
]

config = initial_config
puts
puts
puts
display_config(config)

def config_fitness(config)
  floors = config[:floors]
  weight = 1

  floors[1..4].sum do |floor|
    res = floor.sum(&:length) * weight
    weight *= 16
    res
  end
end

solution.each do |mov|
  dir, generators, microchips = mov
  move_config(config, dir, generators, microchips)
  puts config_fitness(config).to_s(16).rjust(4, "0").chars.join(" ")
end
