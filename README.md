# Results

## Just Parsing
|               | Foundation | vdka/JSON |      Jay | Vapor/JSON | Zewo/JSON |  memcpy(100x) |
|--------------:|-----------:|----------:|---------:|-----------:|----------:|--------------:|
| `-Ounchecked` |      `8ms` |    `16ms` |  `101ms` |    `154ms` |  `57.6ms` |      `5.19ms` |
|          `-O` |   `8.86ms` |  `19.1ms` |  `130ms` |    `173ms` |  `75.2ms` |      `5.37ms` |
|      `-Onone` |   `9.28ms` |   `113ms` |  `595ms` |    `237ms` |   `378ms` |      `7.29ms` |
|  `-c release` |            |           | `87.1ms` |            |           |               |

Note: Foundation here is on Darwin which is not the same as the [this code](https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSJSONSerialization.swift) that will run on linux.

## Parsing & Model Transform
|               | Foundation | vdka/JSON |
|---------------|-----------:|----------:|
| `-Ounchecked` |    `138ms` |  `17.2ms` |
|          `-O` |    `140ms` | 	`21.1ms` |
|      `-Onone` |    `156ms` | 	`99.5ms` |

```swift
struct User {
  let id: String
  let index: Int
  let guid: String
  let isActive: Bool
  let balance: String
  let picture: String
  let age: Int
  let eyeColor: Color
  let name: String
  let gender: Gender
  let company: String
  let email: String
  let phone: String
  let address: String
  let about: String
  let registered: String
  let latitude: Double
  let longitude: Double
  let tags: [String]
  let friends: [Friend]
  let greeting: String
  let favoriteFruit: String

  enum Color: String {
    case red, green, blue, brown
  }

  enum Gender: String {
    case male, female
  }

  struct Friend {
    let id: Int
    let name: String
  }
}
```
