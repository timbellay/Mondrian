//: [Previous](@previous)

//: AppPrototyping - a place to prototype the look and feel of your app.
//:  Created by Tim Bellay on 12/6/15.
//:  Copyright © 2015 Tim Bellay. All rights reserved.

import UIKit
import XCPlayground

// TODO: test search bar.
// TODO: add delegates to Screen and add real tabBars and navBars.
// TODO: fix tabbar.
// TODO: set arbitrary theme color.
// TODO: ability to make custome tableview cells. Start with enum of basic types.

let device = Device.iPhone5s

let screen = Screen(device: device, type: .list, theme: .dark)
screen.view.frame

XCPlayground.XCPlaygroundPage.currentPage.liveView = screen.view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//screen.views[0].hidden = true
//screen.views[1].hidden = true
//screen.views[2].hidden = true
//screen.views[3].hidden = true
//screen.views[4].hidden = true

screen.mainSV?.subviews.count


//outlineViews(screen.views, outlineColor: .blueColor())


//: [Next](@next)

