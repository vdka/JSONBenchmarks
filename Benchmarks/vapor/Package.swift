import PackageDescription

let package = Package(
    name: "vapor",
    dependencies: [
      .Package(url: "../..", majorVersion: 0),
      .Package(url: "https://github.com/vapor/json.git", majorVersion: 0, minor: 4)
    ]
)
