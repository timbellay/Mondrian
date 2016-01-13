//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone5s; let frame = device.frame()
let cell1 = Cell(device: device, cellType: .Simple)
let view = UIView(frame: CGRectMake(0, 0, frame.width, 44))
view.addSubview(cell1.view!)
XCPlaygroundPage.currentPage.liveView = view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
outlineViews([view], outlineColor: .blueColor())

//: [Next](@next)
