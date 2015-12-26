//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone6SPlus
let screen = Screen(device: device, type: .splash, imageName: "splash")
XCPlayground.XCPlaygroundPage.currentPage.liveView = screen.view
//outlineViews([screen.view], outlineColor: .whiteColor())

//: [Next](@next)
