set counters;
set buttons;

param goal_joltages { counters };
param button_joltages { counters, buttons };

var presses { buttons } >= 0 integer;

subject to joltage_level { c in counters }: sum { b in buttons } button_joltages[c, b] * presses[b] = goal_joltages[c];

minimize total_presses: sum { b in buttons } presses[b];
