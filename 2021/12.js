const fs = require("fs")

const INPUT = fs.readFileSync("12.txt", "utf8").split("\n").filter(line => line)
const ADJACENTS = {}

INPUT.forEach(line => {
  const [a, b] = line.split("-")

  ADJACENTS[a] ||= []
  ADJACENTS[b] ||= []
  ADJACENTS[a].push(b)
  ADJACENTS[b].push(a)
})

const CACHE = {}

const findAllPaths = function(start, path, visited, makeAnException) {
  const cacheKey = [start, Object.keys(visited).filter(k => visited[k]).sort(), makeAnException].join(";")

  let res = CACHE[cacheKey]
  if(res === undefined) res = findAllPathsHelper(start, path, visited, makeAnException)

  CACHE[cacheKey] = res

  return res
}

const findAllPathsHelper = function(start, path, visited, makeAnException) {
  if(start === "end") return [path.map(node => node)]

  let res = []

  ADJACENTS[start].forEach(adjacent => {
    const nextMakeAnException = makeAnException && !visited[adjacent]
    const canMakeAnException = makeAnException && (adjacent !== "start") && (adjacent !== "end")

    if(!visited[adjacent] || canMakeAnException) {
      const wasVisited = visited[adjacent]
      if(adjacent.toLowerCase() === adjacent) visited[adjacent] = true
      path.push(adjacent)

      res = res.concat(findAllPaths(adjacent, path, visited, nextMakeAnException))

      path.pop()
      visited[adjacent] = wasVisited
    }
  })

  return res
}

console.log(findAllPaths("start", ["start"], { start: true }, false).length)
console.log(findAllPaths("start", ["start"], { start: true }, true).length)
