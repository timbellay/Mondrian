//: [Previous](@previous)

import UIKit
import XCPlayground

/*
 Returns a UIView representing a status bar.

 [Usage]
 var statusBar = StatusBar(frame: frame, theme: .light)
 statusBar.dark = true
 statusbar.navigation = "Back to Safari"
*/

// TODO: add navigation such as "< back to Facebook" as option to replace carrierSV
// TODO: add wifi/no signal label and strength meter to carrierSV
// TODO: set time with a string

let device = Device.iPhone6Plus
let frame = device.frame()

let statusBar = StatusBar(frame: frame, theme: .light)
XCPlayground.XCPlaygroundPage.currentPage.liveView = statusBar.view
//outlineViews([statusBar.view], outlineColor: .blackColor())

//: [Next](@next)
