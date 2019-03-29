// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "GenericGeometry",
    products: [
        .library(
            name: "GenericGeometry",
            targets: ["GenericGeometry"]),
    ],
    targets: [
        .target(
            name: "GenericGeometry",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "GenericGeometryTests",
            dependencies: ["GenericGeometry"],
            path: "Tests"),
    ]
)
