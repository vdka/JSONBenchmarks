import JSON
import Bench
import struct Bench.User

extension User.Friend: JSONInitializable {

  public init(json: JSON) throws {
    self.id   = try json.get("id")
    self.name = try json.get("name")
  }
}

extension User: JSONInitializable {

  public init(json: JSON) throws {
    self.id             = try json.get("_id")
    self.index          = try json.get("index")
    self.guid           = try json.get("guid")
    self.isActive       = try json.get("isActive")
    self.balance        = try json.get("balance")
    self.picture        = try json.get("picture")
    self.age            = try json.get("age")
    self.eyeColor       = try json.get("eyeColor")
    self.name           = try json.get("name")
    self.gender         = try json.get("gender")
    self.company        = try json.get("company")
    self.email          = try json.get("email")
    self.phone          = try json.get("phone")
    self.address        = try json.get("address")
    self.about          = try json.get("about")
    self.registered     = try json.get("registered")
    self.latitude       = try json.get("latitude")
    self.longitude      = try json.get("longitude")
    self.tags           = json["tags"].array?.flatMap({ $0.string }) ?? []
    self.friends        = try json["friends"].array?.map(Friend.init) ?? []
    self.greeting       = try json.get("greeting")
    self.favoriteFruit  = try json.get("favoriteFruit")
  }
}

public func run(loop times: Int) -> ([UInt8]) throws -> Void {

  return { input in
    for _ in 0..<times {

      _ = try JSON.Parser.parse(input)
    }
  }
}

let results = try bench(this: run(loop: 1))

describe(benchmark: "vdka/json", results)


let modelResults = try bench { bytes in
  let json = try JSON.Parser.parse(bytes)
  _ = try json.array!.map(User.init)
}

describe(benchmark: "vdka/json Model", modelResults)
