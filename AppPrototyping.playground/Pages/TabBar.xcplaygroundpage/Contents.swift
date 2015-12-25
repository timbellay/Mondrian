//: [Previous](@previous)

import UIKit
import XCPlayground

let frame = Device.iPhone6Plus.frame()
let view = UIView(frame: frame)

let tabBar = TabBar(frame: frame, theme: .light)
view.addSubview(tabBar.view)


XCPlayground.XCPlaygroundPage.currentPage.liveView = view
view.frame = frame
outlineViews([view], outlineColor: .blueColor())


//: [Next](@next)
