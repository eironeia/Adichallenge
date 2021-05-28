// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "RxWrapperTests",
  products: [
    .library(name: "RxWrapperTests", targets: ["RxWrapperTests"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/ReactiveX/RxSwift.git",
      .upToNextMajor(from: "6.0.0")
    )
  ],
  targets: [
    .target(
      name: "RxWrapperTests",
      dependencies: ["RxSwift" , "RxCocoa", "RxTest"]
    )
  ]
)
