def initial_config
  floors = [
    [[], []],
    [%w[polonium thulium promethium ruthenium cobalt elerium dilithium], %w[thulium ruthenium cobalt elerium dilithium]],
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

def parse_config(config_hash)
  elevator_hash, floors_hash = config_hash.split("#")

  res = {
    floors: floors_hash.split("|").map do |floor_hash|
      generators_hash, microchips_hash = floor_hash.split(";")
      generators_hash ||= ""
      microchips_hash ||= ""
      [generators_hash, microchips_hash].map do |items_hash|
        items_hash.split(",")
      end
    end,
    elevator: elevator_hash.to_i
  }
end

def items_in_the_first_n_floors(config, n)
  config[:floors][1..n].sum do |items|
    items.sum(&:length)
  end
end

def config_fitness(config)
  floors = config[:floors]
  weight = 1

  floors[1..4].sum do |floor|
    res = floor.sum(&:length) * weight
    weight *= 16
    res
  end
end

def worth_it?(last_config, queue)
  return true if queue.length < 6

  last_config_fitness = config_fitness(last_config)

  queue[-6..-4].any? do |node|
    prev_config_hash, _ = node
    prev_config = parse_config(prev_config_hash)
    prev_config_fitness = config_fitness(prev_config)
    last_config_fitness > prev_config_fitness * 0.95
  end
end

def solve_config(config)
  visited = {}
  queue = []

  config_hash = hashify_config(config)
  visited[config_hash] = true
  queue.push([config_hash, 0])

  best_solution = nil

  until queue.empty?
    node = queue.shift()

    config_hash, steps = node
    config = initial_config()
    config = parse_config(config_hash)

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
          next unless 1 <= nitems && nitems <= 2

          floor.first.combination(ngenerators).each do |generators|
            floor.last.combination(nmicrochips).each do |microchips|
              if move_config(config, dir, generators, microchips)
                config_hash = hashify_config(config)
                if !visited[config_hash] && worth_it?(config, queue) && valid_config?(config) && safe_config?(config)
                  visited[config_hash] = true
                  queue.push([config_hash, steps+1])
                end
                move_config(config, -dir, generators, microchips) || raise("uh oh")
              end
            end
          end
        end
      end
    end
  end

  best_solution
end

solution = solve_config(initial_config)
p solution
