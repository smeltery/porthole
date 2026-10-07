// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "Porthole",
  platforms: [
    .macOS(.v15)
  ],
  products: [
    .library(name: "MonitorCore", targets: ["MonitorCore"]),
    .executable(name: "PortholeApp", targets: ["PortholeApp"])
  ],
  targets: [
    .target(name: "MonitorCore"),
    .executableTarget(
      name: "PortholeApp",
      dependencies: ["MonitorCore"]
    ),
    .testTarget(
      name: "MonitorCoreTests",
      dependencies: ["MonitorCore"]
    )
  ]
)
