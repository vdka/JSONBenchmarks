import func Darwin.C.memcpy
import Bench

public var bytesCopy: [UInt8] = []

public func run(loop times: Int) -> ([UInt8]) throws -> Void {

  return { input in
    for _ in 0..<times {
      var input = input

      bytesCopy.reserveCapacity(input.count)
      memcpy(&input, &bytesCopy, input.count)
    }
  }
}

let results = try bench(this: run(loop: 100))

describe(benchmark: "libc/memcpy", results)

