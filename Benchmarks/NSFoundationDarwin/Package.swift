import PackageDescription

let package = Package(
    name: "NSFoundationDarwin",
    dependencies: [
      .Package(url: "../..", majorVersion: 0),
    ]
)
