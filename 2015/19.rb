REPLACEMENTS = [
  ["Al", "ThF"],
  ["Al", "ThRnFAr"],
  ["B", "BCa"],
  ["B", "TiB"],
  ["B", "TiRnFAr"],
  ["Ca", "CaCa"],
  ["Ca", "PB"],
  ["Ca", "PRnFAr"],
  ["Ca", "SiRnFYFAr"],
  ["Ca", "SiRnMgAr"],
  ["Ca", "SiTh"],
  ["F", "CaF"],
  ["F", "PMg"],
  ["F", "SiAl"],
  ["H", "CRnAlAr"],
  ["H", "CRnFYFYFAr"],
  ["H", "CRnFYMgAr"],
  ["H", "CRnMgYFAr"],
  ["H", "HCa"],
  ["H", "NRnFYFAr"],
  ["H", "NRnMgAr"],
  ["H", "NTh"],
  ["H", "OB"],
  ["H", "ORnFAr"],
  ["Mg", "BF"],
  ["Mg", "TiMg"],
  ["N", "CRnFAr"],
  ["N", "HSi"],
  ["O", "CRnFYFAr"],
  ["O", "CRnMgAr"],
  ["O", "HP"],
  ["O", "NRnFAr"],
  ["O", "OTi"],
  ["P", "CaP"],
  ["P", "PTi"],
  ["P", "SiRnFAr"],
  ["Si", "CaSi"],
  ["Th", "ThCa"],
  ["Ti", "BP"],
  ["Ti", "TiTi"],
  ["e", "HF"],
  ["e", "NAl"],
  ["e", "OMg"]
]

SUPER_REPLACEMENTS = []

SUPER_REPLACEMENTS << REPLACEMENTS.map { |k, v| [k, v] }

(1..5).each do |i|
  puts "step #{i}"

  start = Time.now

  new_molecules = {}

  SUPER_REPLACEMENTS[i] = []

  SUPER_REPLACEMENTS[i-1].each do |k1, v2|
    REPLACEMENTS.each do |k, v|
      index = -1
      while index = v2.index(k, index + 1)
        new_molecule = v2.dup
        new_molecule[index, k.length] = v
        new_molecules[new_molecule] = true

        SUPER_REPLACEMENTS[i] << [k1, new_molecule]
      end
    end
  end

  molecules = new_molecules.keys

  # puts molecules
  # puts molecules.length
  # puts molecules.map(&:length).max

  puts "Done! took #{Time.now - start}s"
end

p SUPER_REPLACEMENTS.sum(&:length)

SUPER_REPLACEMENTS.reverse!

$cache = {}

def find_molecule(target)
  return $cache[target] if $cache.key?(target)
  $cache[target] = do_find_molecule(target)
end

def do_find_molecule(target)
  return { length: 0, path: [target] } if target == "e"

  SUPER_REPLACEMENTS.each_with_index do |replacements, i|
    replacements.each do |k, v|
      index = -1
      while index = target.index(v, index + 1)
        new_target = target.dup
        new_target[index, v.length] = k

        new_path = find_molecule(new_target)
        return { length: new_path[:length] - i + SUPER_REPLACEMENTS.length, path: new_path[:path] + [target] } if new_path
      end
    end
  end

  return nil
end

p find_molecule("HOH")
p find_molecule("HOHOHO")
p find_molecule("ORnPBPMgArCaCaCaSiThCaCaSiThCaCaPBSiRnFArRnFArCaCaSiThCaCaSiThCaCaCaCaCaCaSiRnFYFArSiRnMgArCaSiRnPTiTiBFYPBFArSiRnCaSiRnTiRnFArSiAlArPTiBPTiRnCaSiAlArCaPTiTiBPMgYFArPTiRnFArSiRnCaCaFArRnCaFArCaSiRnSiRnMgArFYCaSiRnMgArCaCaSiThPRnFArPBCaSiRnMgArCaCaSiThCaSiRnTiMgArFArSiThSiThCaCaSiRnMgArCaCaSiRnFArTiBPTiRnCaSiAlArCaPTiRnFArPBPBCaCaSiThCaPBSiThPRnFArSiThCaSiThCaSiThCaPTiBSiRnFYFArCaCaPRnFArPBCaCaPBSiRnTiRnFArCaPRnFArSiRnCaCaCaSiThCaRnCaFArYCaSiRnFArBCaCaCaSiThFArPBFArCaSiRnFArRnCaCaCaFArSiRnFArTiRnPMgArF")
