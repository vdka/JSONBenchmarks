
import Foundation

public enum Fixture: String {
  case large
  case large_min
}

/// memoize it.
var fixtures: [Fixture: [UInt8]] = [:]

public func describe(benchmark name: String, _ results: (Double, Double)) {

  print(name + ":")
  print("  " + "average:   " + results.0.description + "s")
  print("  " + "stddev:    " + results.1.description)
  print("")
}

public func bench(times: Int = 10, using fixture: Fixture = .large, this: ([UInt8]) throws -> Void) throws -> (average: Double, variance: Double) {
  let jsonBytes = fixtures[fixture] ?? loadFixture(fixture.rawValue)
  if fixtures[fixture] == nil {
    fixtures[fixture] = jsonBytes
  }

  var timings: [Double] = []

  for _ in 1..<times {
    let time = try measure {
      try this(jsonBytes)
    }
    timings.append(time)
  }

  let total = timings.reduce(0, +)
  let mean = total / Double(times)

  var deviation: Double = 0

  for time in timings {
    let difference = time - mean
    deviation += difference * difference
  }

  let variance = deviation / Double(times)

  return (average: mean, variance: variance)
}

func urlForFixture(_ name: String) -> URL {

  let parent = (#file).components(separatedBy: "/").dropLast(2).joined(separator: "/")
  let url = URL(string: "file://\(parent)/Fixtures/\(name).json")!
  print("Loading fixture from url \(url)")
  return url
}

func loadFixture(_ name: String) -> [UInt8] {

  let url = urlForFixture(name)
  let data = Array(try! String(contentsOf: url).utf8)
  return data
}

func gettime() -> Double {

  var tv = timeval()
  gettimeofday(&tv, nil)

  return Double(tv.tv_sec) + Double(tv.tv_usec) / 1000000
}

public func measure(_ closure: () throws -> Void) rethrows -> Double {

  let begin = gettime()

  try closure()

  let end = gettime()

  return end - begin
}

