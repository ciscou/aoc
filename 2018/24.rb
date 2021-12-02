INPUT = File.read(__FILE__.sub('.rb', '.txt')).lines.map(&:chomp)

class Group
  def initialize(type:, index:, units:, hit_points:, immunities:, weaknesses:, damage:, attack_type:, initiative:)
    @type = type
    @index = index
    @units = units
    @hit_points = hit_points
    @immunities = immunities
    @weaknesses = weaknesses
    @damage = damage
    @attack_type = attack_type
    @initiative = initiative
  end

  attr_reader :type, :index, :units, :immunities, :weaknesses, :initiative, :target

  def effective_power
    @units * @damage
  end

  def calculate_damage(other_group)
    factor = 1

    if other_group.immunities.include?(@attack_type)
      factor = 0
    elsif other_group.weaknesses.include?(@attack_type)
      factor = 2
    end

    factor * effective_power
  end

  def select_target!(other_groups)
    @target = other_groups.sort_by do |other_group|
      [
        calculate_damage(other_group),
        other_group.effective_power,
        other_group.initiative,
      ]
    end.last

    @target = nil if @target && calculate_damage(@target) == 0

    @target
  end

  def attack!
    return if @target.nil?

    @target.receive_damage!(calculate_damage(@target))
  end

  def receive_damage!(damage)
    lost_units = [damage / @hit_points, @units].min
    @units -= lost_units

    lost_units
  end
end

immune_system = []
infection = []
type = nil

INPUT.each do |line|
  case line
  when "Immune System:"
    type = :immune_system
  when "Infection:"
    type = :infection
  when ""
    # no-op
  else
    /^(\d+) units each with (\d+) hit points( \([^)]+\))? with an attack that does (\d+) (\w+) damage at initiative (\d+)$/.match(line)
    immunities = []
    weaknesses = []

    if $3
      $3[2..-2].split("; ").each do |immunities_or_weaknesses|
        if immunities_or_weaknesses.start_with?("immune to ")
          immunities += immunities_or_weaknesses[10..-1].split(", ")
        elsif immunities_or_weaknesses.start_with?("weak to ")
          weaknesses += immunities_or_weaknesses[8..-1].split(", ")
        else
          raise "cannot parse immunities and weaknesses"
        end
      end
    end

    current_groups = type == :immune_system ? immune_system : infection
    current_groups << Group.new(type: type, index: current_groups.length + 1, units: $1.to_i, hit_points: $2.to_i, immunities: immunities, weaknesses: weaknesses, damage: $4.to_i, attack_type: $5, initiative: $6.to_i)
  end
end

loop do
  puts "Immune System:"
  immune_system.each do |group|
    puts "Group #{group.index} contains #{group.units} units"
  end
  puts "Infection:"
  infection.each do |group|
    puts "Group #{group.index} contains #{group.units} units"
  end

  break if [immune_system, infection].any?(&:empty?)

  puts

  infection.each do |group1|
    immune_system.each do |group2|
      damage = group1.calculate_damage(group2)
      puts "Infection group #{group1.index} would deal defending group #{group2.index} #{damage} damage" unless damage == 0
    end
  end

  immune_system.each do |group1|
    infection.each do |group2|
      damage = group1.calculate_damage(group2)
      puts "Immune System group #{group1.index} would deal defending group #{group2.index} #{damage} damage" unless damage == 0
    end
  end

  selected_targets = []

  (immune_system + infection).sort_by { |group| [group.effective_power, group.initiative] }.reverse_each do |group|
    defending_groups = group.type == :immune_system ? infection : immune_system
    target = group.select_target!(defending_groups - selected_targets)
    selected_targets << target unless target.nil?
  end

  puts

  (immune_system + infection).sort_by(&:initiative).reverse_each do |group|
    killed_units = group.attack!
    p [group.type, group.index, group.target && group.target.type, group.target && group.target.index, killed_units]
  end

  immune_system.select! { |group| group.units > 0 }
  infection.select! { |group| group.units > 0 }
end

puts immune_system.sum(&:units)
puts infection.sum(&:units)
