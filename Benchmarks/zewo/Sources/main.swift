import JSON
import Bench

public func run(loop times: Int) -> ([UInt8]) throws -> Void {

  return { bytes in
    for _ in 0..<times {

        let data = Data(bytes)

      _ = try JSONParser().parse(data: data)
    }
  }
}

let results = try bench(this: run(loop: 1))

describe(benchmark: "zewo/json", results)

