// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "MtvProtocol",
    products: [
        .library(name: "MtvProtocol", targets: ["MtvProtocol"]),
    ],
    targets: [
        .target(name: "MtvProtocol"),
    ]
)