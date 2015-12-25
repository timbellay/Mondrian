//: [Previous](@previous)

import UIKit
import XCPlayground

let frame = Device.iPhone6Plus.frame()
let view = UIView(frame: frame)

//let statusBar = StatusBar(superView: view, theme: .dark)
//statusBar.view.frame
//view.addSubview(statusBar.view)

let navBar = NavigationBar(frame: frame, theme: .light, title: "Hello")
view.addSubview(navBar.view)

XCPlayground.XCPlaygroundPage.currentPage.liveView = view
view.frame = frame
navBar.view.frame
//outlineViews([view], outlineColor: .blueColor())




//: [Next](@next)
