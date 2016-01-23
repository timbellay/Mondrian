//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone4s; let frame = device.frame()

var cell1 = Cell(device: device, cellType: .Simple)
cell1.members

var otherLabel = UILabel(text: "Tim", font: Font.smalltext.create(), textColor: .whiteColor(), labelColor: .blackColor())

cell1.members["label"] // = otherLabel

cell1.containerView?.view?.frame = CGRectMake(0, 0, frame.width, 100)
cell1.containerView?.view?.layoutIfNeeded()

XCPlaygroundPage.currentPage.liveView = cell1.containerView?.view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

outlineViews([cell1.containerView!.view!], outlineColor: .blueColor())

//: [Next](@next)
