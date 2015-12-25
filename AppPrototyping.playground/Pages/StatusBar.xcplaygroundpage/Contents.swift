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


let frame = CGRectMake(0, 0, 375, 20)
var statusBar = StatusBar(frame: frame, theme: .light
)

//outlineViews([statusBar.view], outlineColor: .blackColor())

XCPlayground.XCPlaygroundPage.currentPage.liveView = statusBar.view
//: [Next](@next)
