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
    destination_end = destination_start + length - 1
    source_end = source_start + length - 1
    current_map << { destination: destination_start..destination_end, source: source_start..source_end }
  end
end

def kk(maps, source)
  maps.each do |map|
    if map[:source].cover?(source)
      return map[:destination].begin + source - map[:source].begin
    end
  end

  source
end

seed_to_location = {}

seeds.each do |seed|
  soil = kk(seed_to_soil, seed)
  fertilizer = kk(soil_to_fertilizer, soil)
  water = kk(fertilizer_to_water, fertilizer)
  light = kk(water_to_light, water)
  temperature = kk(light_to_temperature, light)
  humidity = kk(temperature_to_humidity, temperature)
  location = kk(humidity_to_location, humidity)

  seed_to_location[seed] = location
end

puts seed_to_location.values.min
