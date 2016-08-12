import PackageDescription

let package = Package(
    name: "jay",
    dependencies: [
      .Package(url: "../..", majorVersion: 0),
      .Package(url: "https://github.com/czechboy0/Jay.git", majorVersion: 0, minor: 16)
    ]
)
