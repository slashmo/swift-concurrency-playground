// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "concurrency",
    targets: [
        .executableTarget(name: "Playground", swiftSettings: [
            .unsafeFlags([
                "-Xfrontend", "-enable-experimental-concurrency",
                "-Xfrontend", "-disable-availability-checking",
                "-parse-as-library",
            ])
        ]),
    ]
)
