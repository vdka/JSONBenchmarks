import JSON
import Bench

public func run(loop times: Int) -> ([UInt8]) throws -> Void {

  return { input in
    for _ in 0..<times {

      _ = try JSON(bytes: input)
    }
  }
}

let results = try bench(this: run(loop: 1))

describe(benchmark: "vapor/json", results)

