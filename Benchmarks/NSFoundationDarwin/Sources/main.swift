import Foundation
import Bench

enum JSONError: Swift.Error {
  case typeMismatch
}

extension User.Friend {

  public init(json: Any) throws {
    guard
      let json  = json as? NSDictionary,
      let id    = json["id"] as? Int,
      let name  = json["name"] as? String
      else { throw JSONError.typeMismatch }

    self.id   = id
    self.name = name
  }
}

extension User {

  public init(json: Any) throws {
    guard
      let json              = json as? NSDictionary,
      let id                = json["_id"] as? String,
      let index             = json["index"] as? Int,
      let guid              = json["guid"] as? String,
      let isActive          = json["isActive"] as? Bool,
      let balance           = json["balance"] as? String,
      let picture           = json["picture"] as? String,
      let age               = json["age"] as? Int,
      let eyeColorRawValue  = json["eyeColor"] as? String,
      let eyeColor          = Color(rawValue: eyeColorRawValue),
      let name              = json["name"] as? String,
      let genderRawValue    = json["gender"] as? String,
      let gender            = Gender(rawValue: genderRawValue),
      let company           = json["company"] as? String,
      let email             = json["email"] as? String,
      let phone             = json["phone"] as? String,
      let address           = json["address"] as? String,
      let about             = json["about"] as? String,
      let registered        = json["registered"] as? String,
      let latitude          = json["latitude"] as? Double,
      let longitude         = json["longitude"] as? Double,
      let tags              = json["tags"] as? [String],
      let friendsObjects    = json["friends"] as? NSArray,
      //let tags          = json["tags"].array?.flatMap({ $0.string }) ?? []
      //let friends       = try json["friends"].array?.map(Friend.init) ?? []
      let greeting          = json["greeting"] as? String,
      let favoriteFruit     = json["favoriteFruit"] as? String
      else { throw JSONError.typeMismatch }

    self.id             = id
    self.index          = index
    self.guid           = guid
    self.isActive       = isActive
    self.balance        = balance
    self.picture        = picture
    self.age            = age
    self.eyeColor       = eyeColor
    self.name           = name
    self.gender         = gender
    self.company        = company
    self.email          = email
    self.phone          = phone
    self.address        = address
    self.about          = about
    self.registered     = registered
    self.latitude       = latitude
    self.longitude      = longitude
    self.tags           = tags
    self.friends        = try friendsObjects.map(Friend.init)
    self.greeting       = greeting
    self.favoriteFruit  = favoriteFruit
  }
}


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

let modelResults = try bench { bytes in
  let data = Data(bytes: bytes)

  let json: Any = try JSONSerialization.jsonObject(with: data)
  guard let array = json as? NSArray else { fatalError() }
  _ = try array.map(User.init)
}

describe(benchmark: "Foundation/JSONSerialization(Darwin) Model", modelResults)

let singleModelResults = try bench(times: 100, using: "single") { bytes in
  let data = Data(bytes: bytes)

  let json: Any = try JSONSerialization.jsonObject(with: data)
  _ = try User(json: json)
}

describe(benchmark: "Foundation/JSONSerialization(Darwin) Single Model", singleModelResults)

