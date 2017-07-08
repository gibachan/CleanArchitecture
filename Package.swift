// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "CleanArchitecture",
    targets: [
        Target(name: "Core"),
        Target(
            name: "ConsoleApp",
            dependencies: ["Core"]
        )
    ],
    dependencies: [
        .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 2)
    ]
)
