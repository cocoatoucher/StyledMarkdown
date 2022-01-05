// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StyledMarkdown",
    platforms: [
        .iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8)
    ],
    products: [
        .library(
            name: "StyledMarkdown",
            targets: ["StyledMarkdown"]
        ),
    ],
    targets: [
        .target(
            name: "StyledMarkdown",
            path: "Sources"
        ),
        .testTarget(
            name: "StyledMarkdownTests",
            dependencies: ["StyledMarkdown"]
        ),
    ]
)
