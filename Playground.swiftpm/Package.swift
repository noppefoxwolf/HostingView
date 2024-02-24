// swift-tools-version: 5.9

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Playground",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .iOSApplication(
            name: "Playground",
            targets: ["AppModule"],
            bundleIdentifier: "E20AACA3-FADA-4637-BA1F-817917CB833A",
            teamIdentifier: "",
            displayVersion: "1.0",
            bundleVersion: "1",
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    
    dependencies: [
        .package(path: "../")
    ],
    
    targets: [
        .executableTarget(
            name: "AppModule",
            
            dependencies: [
                .product(
                    name: "HostingView",
                    package: "HostingView"
                )
            ],
            
            path: "."
        )
    ]
)
