//// swift-tools-version: 5.8
//// The swift-tools-version declares the minimum version of Swift required to build this package.
//import PackageDescription
//
//let package = Package(
//    name: "Pomodoro",
//    platforms: [
//        .iOS(.v16)
//    ],
//    products: [
//        .library(
//            name: "Firebase",
//            targets: ["Pomodoro"]
//        ),
//        .library(
//            name: "FirebaseCore",
//            targets: ["Pomodoro"]
//        ),
//        .library(
//            name: "FirebaseAnalytics",
//            targets: ["Pomodoro"]
//        )
//    ],
//    dependencies: [
//        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.8.1")
//    ],
//    targets: [
//        .target(
//            name: "Pomodoro",
//            dependencies: [
//                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
//            ],
//            path: "Pomodoro"
//        ),
//        .testTarget(
//            name: "PomodoroTests",
//            dependencies: [
//                .target(name: "Pomodoro"),
//                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
//            ],
//            path: "PomodoroTests"
//        ),
//    ]
//)
