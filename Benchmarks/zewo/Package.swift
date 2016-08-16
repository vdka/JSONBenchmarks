import PackageDescription

let package = Package(
    name: "zewo",
    dependencies: [
        .Package(url: "../..", majorVersion: 0),
        .Package(url: "https://github.com/Zewo/JSON.git", majorVersion: 0, minor: 12),
    ]
)
