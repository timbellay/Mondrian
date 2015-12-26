//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone6Plus
let frame = device.frame()
let tabBar = TabBar(frame: frame, theme: .light)

XCPlayground.XCPlaygroundPage.currentPage.liveView = tabBar.view
outlineViews([tabBar.view], outlineColor: .blueColor())

//: [Next](@next)
