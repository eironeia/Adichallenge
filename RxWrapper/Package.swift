// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "RxWrapper",
  products: [
    .library(name: "RxWrapper", targets: ["RxWrapper"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/ReactiveX/RxSwift.git",
      .upToNextMajor(from: "6.0.0")
    )
  ],
  targets: [
    .target(
      name: "RxWrapper",
      dependencies: ["RxSwift" , "RxCocoa", "RxRelay"]
    )
  ]
)
