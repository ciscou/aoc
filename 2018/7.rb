input = <<EOS
Step Y must be finished before step A can begin.
Step O must be finished before step C can begin.
Step P must be finished before step A can begin.
Step D must be finished before step N can begin.
Step T must be finished before step G can begin.
Step L must be finished before step M can begin.
Step X must be finished before step V can begin.
Step C must be finished before step R can begin.
Step G must be finished before step E can begin.
Step H must be finished before step N can begin.
Step Q must be finished before step B can begin.
Step S must be finished before step R can begin.
Step M must be finished before step F can begin.
Step N must be finished before step Z can begin.
Step E must be finished before step I can begin.
Step A must be finished before step R can begin.
Step Z must be finished before step F can begin.
Step K must be finished before step V can begin.
Step I must be finished before step J can begin.
Step R must be finished before step W can begin.
Step B must be finished before step J can begin.
Step W must be finished before step V can begin.
Step V must be finished before step F can begin.
Step U must be finished before step F can begin.
Step F must be finished before step J can begin.
Step X must be finished before step C can begin.
Step T must be finished before step Q can begin.
Step B must be finished before step F can begin.
Step Y must be finished before step L can begin.
Step P must be finished before step E can begin.
Step A must be finished before step J can begin.
Step S must be finished before step I can begin.
Step S must be finished before step A can begin.
Step K must be finished before step R can begin.
Step D must be finished before step C can begin.
Step R must be finished before step U can begin.
Step K must be finished before step U can begin.
Step D must be finished before step K can begin.
Step S must be finished before step M can begin.
Step D must be finished before step E can begin.
Step A must be finished before step K can begin.
Step G must be finished before step I can begin.
Step O must be finished before step M can begin.
Step U must be finished before step J can begin.
Step T must be finished before step S can begin.
Step C must be finished before step M can begin.
Step S must be finished before step J can begin.
Step N must be finished before step V can begin.
Step P must be finished before step N can begin.
Step D must be finished before step M can begin.
Step A must be finished before step B can begin.
Step Z must be finished before step R can begin.
Step T must be finished before step N can begin.
Step K must be finished before step J can begin.
Step N must be finished before step A can begin.
Step M must be finished before step R can begin.
Step E must be finished before step A can begin.
Step Y must be finished before step O can begin.
Step O must be finished before step B can begin.
Step O must be finished before step A can begin.
Step I must be finished before step V can begin.
Step M must be finished before step Z can begin.
Step D must be finished before step U can begin.
Step O must be finished before step S can begin.
Step Z must be finished before step W can begin.
Step M must be finished before step A can begin.
Step N must be finished before step E can begin.
Step M must be finished before step U can begin.
Step R must be finished before step J can begin.
Step W must be finished before step F can begin.
Step I must be finished before step U can begin.
Step E must be finished before step U can begin.
Step Y must be finished before step R can begin.
Step Z must be finished before step K can begin.
Step C must be finished before step F can begin.
Step B must be finished before step V can begin.
Step G must be finished before step B can begin.
Step O must be finished before step G can begin.
Step E must be finished before step Z can begin.
Step A must be finished before step V can begin.
Step Y must be finished before step Q can begin.
Step P must be finished before step D can begin.
Step X must be finished before step G can begin.
Step I must be finished before step W can begin.
Step M must be finished before step V can begin.
Step T must be finished before step M can begin.
Step G must be finished before step J can begin.
Step T must be finished before step I can begin.
Step H must be finished before step B can begin.
Step C must be finished before step E can begin.
Step Q must be finished before step V can begin.
Step H must be finished before step U can begin.
Step X must be finished before step K can begin.
Step D must be finished before step T can begin.
Step X must be finished before step W can begin.
Step P must be finished before step Z can begin.
Step C must be finished before step U can begin.
Step Y must be finished before step Z can begin.
Step L must be finished before step F can begin.
Step C must be finished before step J can begin.
Step T must be finished before step W can begin.
EOS

tasks = Hash.new { |h, k| h[k] = { name: k, dependencies: [], done: false, in_progress: false } }

input.lines.each do |line|
  line.chomp!

  case line
  when /^Step ([A-Z]) must be finished before step ([A-Z]) can begin\.$/
    tasks[$2][:dependencies] << tasks[$1]
  else
    raise "cannot parse line #{line}"
  end
end

order = []

until tasks.values.all? { |t| t[:done] }
  available_tasks = tasks.values.select { |t| !t[:done] && t[:dependencies].all? { |d| d[:done] } }
  next_task = available_tasks.min_by { |t| t[:name] }
  next_task[:done] = true
  order << next_task[:name]
end

puts order.join("")

tasks.values.each { |t| t[:done] = false }

elapsed = 0
elves = 5.times.map { nil }

until tasks.values.all? { |t| t[:done] }
  elves.map! do |e|
    if !e.nil? && e[:eta] == 0
      e[:done] = true
      nil
    else
      e
    end
  end

  available_tasks = tasks.values.select { |t| !t[:done] && !t[:in_progress] && t[:dependencies].all? { |d| d[:done] } }
  next_tasks = available_tasks.sort_by { |t| t[:name] }

  elves.map! do |e|
    if e.nil?
      next_task = next_tasks.shift

      if next_task
        next_task[:in_progress] = true
        next_task[:eta] = 60 + next_task[:name].ord - "A".ord
        next_task
      else
        nil
      end
    else
      e[:eta] -= 1
      e
    end
  end

  p [elapsed, elves.map { |e| e.nil? ? "." : e[:name] }]

  elapsed += 1
end

puts elapsed - 1
