//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone6Plus
let frame = device.frame()
let appearance = Appearance(theme: .Custom, textColor: .yellowColor(), labelColor: .purpleColor())
let statusBar = StatusBar(frame: frame, appearance: appearance)
XCPlayground.XCPlaygroundPage.currentPage.liveView = statusBar.view
//outlineViews([statusBar.view], outlineColor: .blackColor())

//: [Next](@next)
