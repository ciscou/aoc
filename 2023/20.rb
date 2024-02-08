INPUT = File.readlines(__FILE__.sub('.rb', '.txt'), chomp: true)

modules = {}

INPUT.each do |line|
  name, destination_modules = line.split(" -> ")
  type = nil
  extra = {}
  if name.start_with?("%")
    name.delete_prefix!("%")
    type = "flip_flop"
    extra = { on: false }
  end
  if name.start_with?("&")
    name.delete_prefix!("&")
    type = "conjunction"
    extra = { last_received: Hash.new(false) }
  end
  if name == "broadcaster"
    type = "broadcaster"
  end
  modules[name] = { type: type, name: name, destination_modules: destination_modules.split(", "), source_modules: [] }.merge(extra)
end

modules.each_value do |mod|
  mod[:destination_modules].each do |dest|
    next unless modules[dest]
    modules[dest][:source_modules] << mod[:name]
  end
end

broadcaster = modules["broadcaster"]

low_pulses = 0
high_pulses = 0

1_000.times do
  queue = []

  low_pulses += 1 # button to broadcaster

  broadcaster[:destination_modules].each do |mod|
    queue << [broadcaster[:name], false, mod]
  end

  until queue.empty?
    pulse = queue.shift

    source, pulse, destination = pulse

    if pulse
      high_pulses += 1
    else
      low_pulses += 1
    end

    mod = modules[destination]
    next unless mod
    case mod[:type]
    when "flip_flop"
      unless pulse
        mod[:on] = !mod[:on]
        mod[:destination_modules].each do |dest| # TODO: should be one?
          queue << [mod[:name], mod[:on], dest]
        end
      end
    when "conjunction"
      mod[:last_received][source] = pulse
      all_high = mod[:source_modules].all? { mod[:last_received][_1] }
      mod[:destination_modules].each do |dest| # TODO: should be one?
        queue << [mod[:name], !all_high, dest]
      end
    end
  end
end

puts low_pulses
puts high_pulses
puts low_pulses * high_pulses
