//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone6Plus
let frame = device.frame()
let appearance = Appearance(theme: .Custom, textColor: .yellowColor(), labelColor: .purpleColor())
let tabBar = TabBar(frame: frame, appearance: appearance)

XCPlayground.XCPlaygroundPage.currentPage.liveView = tabBar.view
//outlineViews([tabBar.view], outlineColor: .blueColor())

tabBar.view.frame

//: [Next](@next)
