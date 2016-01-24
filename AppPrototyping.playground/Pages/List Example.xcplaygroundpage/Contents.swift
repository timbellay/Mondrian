//: [Previous](@previous)

//: AppPrototyping - a place to prototype the look and feel of your app.
//:  Created by Tim Bellay on 12/6/15.
//:  Copyright © 2015 Tim Bellay. All rights reserved.

import UIKit
import XCPlayground

let device = Device.iPhone5s
let appearance = Appearance(theme: .Custom, textColor: .yellowColor(), labelColor: .purpleColor())
let screen = Screen(device: device, type: .list, appearance: appearance)
screen.view.frame

XCPlayground.XCPlaygroundPage.currentPage.liveView = screen.view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

screen.mainSV?.subviews.count

//outlineViews(screen.views, outlineColor: .blueColor())


//: [Next](@next)

