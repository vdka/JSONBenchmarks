import PackageDescription

let package = Package(
    name: "memcpy",
    dependencies: [
      .Package(url: "../..", majorVersion: 0),
    ]
)
