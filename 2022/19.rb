# basically stolen from https://nickymeuleman.netlify.app/garden/aoc2022-day19
# https://github.com/NickyMeuleman/scrapyard/blob/main/advent_of_code/2022/src/day_19.rs

INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

blueprints = INPUT.map do |line|
  costs = line.split(": ").last
  ore, clay, obsidian, geode = costs.split(". ").map(&:split)

  {
    ore: { ore: ore[-2].to_i },
    clay: { ore: clay[-2].to_i },
    obsidian: { ore: obsidian[-5].to_i, clay: obsidian[-2].to_i },
    geode: { ore: geode[-5].to_i, obsidian: geode[-2].to_i },
  }
end

def max_geodes(blueprint, start_time)
  res = 0

  max_robots = Hash.new(0)
  blueprint.each do |robot, costs|
    costs.each do |material, amount|
      max_robots[material] = amount if amount > max_robots[material]
    end
  end
  max_robots[:geode] = Float::INFINITY

  start_robots = { ore: 1, clay: 0, obsidian: 0, geode: 0 }
  start_materials = { ore: 0, clay: 0, obsidian: 0, geode: 0 }
  start_state = { robots: start_robots, materials: start_materials, time: start_time }

  queue = []
  queue.push(start_state)

  until queue.empty?
    state = queue.pop

    robots, materials, time = state.values_at(:robots, :materials, :time)

    next if time < 1
    next if (time * (time - 1)) / 2 + materials[:geode] + time * robots[:geode] < res

    res = [res, materials[:geode] + time * robots[:geode]].max

    blueprint.each do |robot, costs|
      next unless costs.keys.all? { robots[_1] > 0 }
      next unless robots[robot] < max_robots[robot]

      need_to_wait = costs.map do |material, amount|
        if materials[material] >= amount
          0
        else
          (amount - materials[material] + robots[material] - 1) / robots[material]
        end
      end.max + 1

      next if time - need_to_wait < 0

      next_robots = robots.dup

      next_robots[robot] += 1

      next_materials = materials.dup

      robots.each do |material, amount|
        next_materials[material] += (need_to_wait) * amount
      end

      costs.each do |material, amount|
        next_materials[material] -= amount
      end

      next_time = time - need_to_wait

      next_state = { robots: next_robots, materials: next_materials, time: next_time }

      queue.push(next_state)
    end
  end

  res
end

part1 = blueprints.map.with_index do |blueprint, i|
  max_geodes(blueprint, 24) * (i + 1)
end.sum

puts part1

part2 = blueprints.first(3).map do |blueprint|
  max_geodes(blueprint, 32)
end.reduce(:*)

puts part2
