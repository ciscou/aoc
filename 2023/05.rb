INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

seeds = []
seed_to_soil = []
soil_to_fertilizer = []
fertilizer_to_water = []
water_to_light = []
light_to_temperature = []
temperature_to_humidity = []
humidity_to_location = []
current_map = nil

def build_range(start, length)
  start..(start + length - 1)
end

INPUT.each do |line|
  next if line.empty?

  if line.start_with? "seeds: "
    seeds += line.split(": ").last.split.map(&:to_i)
  elsif line == "seed-to-soil map:"
    current_map = seed_to_soil
  elsif line == "soil-to-fertilizer map:"
    current_map = soil_to_fertilizer
  elsif line == "fertilizer-to-water map:"
    current_map = fertilizer_to_water
  elsif line == "water-to-light map:"
    current_map = water_to_light
  elsif line == "light-to-temperature map:"
    current_map = light_to_temperature
  elsif line == "temperature-to-humidity map:"
    current_map = temperature_to_humidity
  elsif line == "humidity-to-location map:"
    current_map = humidity_to_location
  else
    destination_start, source_start, length = line.split.map(&:to_i)
    current_map << { destination: build_range(destination_start, length), source: build_range(source_start, length) }
  end
end

def corresponding(maps, source)
  maps.each do |map|
    if map[:source].cover?(source)
      return map[:destination].begin + source - map[:source].begin
    end
  end

  source
end

part1 = Float::INFINITY

seeds.each do |seed|
  soil = corresponding(seed_to_soil, seed)
  fertilizer = corresponding(soil_to_fertilizer, soil)
  water = corresponding(fertilizer_to_water, fertilizer)
  light = corresponding(water_to_light, water)
  temperature = corresponding(light_to_temperature, light)
  humidity = corresponding(temperature_to_humidity, temperature)
  location = corresponding(humidity_to_location, humidity)

  part1 = [location, part1].min
end

puts part1

part2 = Float::INFINITY

seeds.each_slice(2) do |seed_range|
  build_range(seed_range.first, seed_range.last).each do |seed|
    soil = corresponding(seed_to_soil, seed)
    fertilizer = corresponding(soil_to_fertilizer, soil)
    water = corresponding(fertilizer_to_water, fertilizer)
    light = corresponding(water_to_light, water)
    temperature = corresponding(light_to_temperature, light)
    humidity = corresponding(temperature_to_humidity, temperature)
    location = corresponding(humidity_to_location, humidity)

    part2 = [location, part2].min
  end
end

puts part2
