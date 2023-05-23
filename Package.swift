// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Secp256k1Kit",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Secp256k1Kit",
            targets: ["Secp256k1Kit"]),
        .library(
            name: "CSecp256k1",
            targets: ["CSecp256k1"]),
        .library(
            name: "BIP32Swift",
            targets: ["BIP32Swift"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.4.1"),
        .package(url: "https://github.com/mathwallet/Base58Swift.git", from: "0.0.1"),
        .package(url: "https://github.com/mathwallet/RIPEMDSwift.git", from: "0.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Secp256k1Kit",
            dependencies: ["CSecp256k1"]),
        .target(
            name: "CSecp256k1",
            dependencies: [],
            cSettings: [
                // Basic config values that are universal and require no dependencies.
                .define("ECMULT_GEN_PREC_BITS", to: "4"),
                .define("ECMULT_WINDOW_SIZE", to: "15"),
                // Enabling additional secp256k1 modules.
                .define("ENABLE_MODULE_ECDH"),
                .define("ENABLE_MODULE_EXTRAKEYS"),
                .define("ENABLE_MODULE_RECOVERY"),
                .define("ENABLE_MODULE_SCHNORRSIG")
            ]),
        .target(
            name: "BIP32Swift",
            dependencies: ["Secp256k1Kit", "BigInt", "CryptoSwift", "Base58Swift", "RIPEMDSwift"]),
        .testTarget(
            name: "Secp256k1KitTests",
            dependencies: ["Secp256k1Kit"]),
    ],
    swiftLanguageVersions: [.v5],
    cLanguageStandard: .c89
)
