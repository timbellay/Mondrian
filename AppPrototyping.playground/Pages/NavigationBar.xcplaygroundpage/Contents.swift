//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone6Plus
let frame = device.frame()
let navBar = NavigationBar(frame: frame, theme: .light, title: "Hello")

XCPlayground.XCPlaygroundPage.currentPage.liveView = navBar.view
outlineViews([navBar.view], outlineColor: .blueColor())

//: [Next](@next)
