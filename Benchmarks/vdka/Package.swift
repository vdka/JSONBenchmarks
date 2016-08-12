import PackageDescription

let package = Package(
    name: "vdka",
    dependencies: [
      .Package(url: "../..", majorVersion: 0),
      .Package(url: "https://github.com/vdka/json.git", majorVersion: 0, minor: 7)
    ]
)
