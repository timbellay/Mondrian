//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone6Plus
let frame = device.frame()
let tabBar = TabBar(frame: frame, theme: .dark)

XCPlayground.XCPlaygroundPage.currentPage.liveView = tabBar.view
//outlineViews([tabBar.view], outlineColor: .blueColor())

tabBar.view.frame

//: [Next](@next)
