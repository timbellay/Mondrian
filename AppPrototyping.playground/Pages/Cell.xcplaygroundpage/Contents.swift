//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone4s; var frame = device.frame()

frame
let cell1 = Cell(device: device, cellType: .Simple)

cell1.containerView?.view?.frame = CGRectMake(0, 0, frame.width, 100)
XCPlaygroundPage.currentPage.liveView = cell1.containerView?.view

//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
outlineViews([cell1.containerView!.view!], outlineColor: .blueColor())

//let subview = UIView(width: 44, height: 44, color: .darkGrayColor())
//let subview2 = UIView(width: 40, height: 40, color: .purpleColor())
//let subview3 = UIView(width: 88, height: 40, color: .blueColor())
//let subview4 = UIView(width: 20, height: 20, color: .blackColor())
//let cv = ContainerView(width: frame.width, height: 100, color: .lightGrayColor(), marginInset: 8)
//cv.stickSubviewToInsideMargin(.Left, subview: subview, byAmount: 0)
//cv.stickSubviewToInsideMargin(.Top, subview: subview, byAmount: 0)
//cv.stickSubviewToSubview(subview2, direction: .Right, subview2: subview, byAmount: 6, align: .Top)
//cv.stickSubviewToSubview(subview3, direction: .Down, subview2: subview2, byAmount: 6, align: .Left)
//cv.stickSubviewToSubview(subview4, direction: .Down, subview2: subview, byAmount: 10, align: .CenterX)
//
//cv.view?.frame = CGRectMake(0, 0, frame.width, 100)
//XCPlaygroundPage.currentPage.liveView = cv.view

//: [Next](@next)
