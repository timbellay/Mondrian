//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone6Plus
let frame = device.frame()
var navBar = NavigationBar(frame: frame, theme: .light, title: "Title")
navBar.containerView?.view?.frame = CGRectMake(0, 0, frame.width, 44)
XCPlayground.XCPlaygroundPage.currentPage.liveView = navBar.containerView?.view
outlineViews([navBar.containerView!.view!], outlineColor: .blueColor())


//: [Next](@next)
