import Foundation
import Bench

var data: Data = Data()

public func run(loop times: Int) -> ([UInt8]) throws -> Void {

  return { input in
    for _ in 0..<times {

      let data = Data(bytes: input)

      _ = try! JSONSerialization.jsonObject(with: data, options: [])
    }
  }
}

let results = try bench(this: run(loop: 1))

describe(benchmark: "Foundation/JSONSerialization(Darwin)", results)

