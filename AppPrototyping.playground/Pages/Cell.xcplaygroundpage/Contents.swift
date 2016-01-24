//: [Previous](@previous)

import UIKit
import XCPlayground

let device = Device.iPhone4s; let frame = device.frame()
let appearance = Appearance(theme: .Dark, textColor: nil, labelColor: nil)
var cell1 = Cell(device: device, cellType: .Simple, appearance: appearance)
cell1.members

var otherLabel = UILabel(text: "Tim", font: Font.SmallText.create(), textColor: .whiteColor(), labelColor: .blackColor())

cell1.members["label"] // = otherLabel

cell1.containerView?.view?.frame = CGRectMake(0, 0, frame.width, 100)
cell1.containerView?.view?.layoutIfNeeded()

XCPlaygroundPage.currentPage.liveView = cell1.containerView?.view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

outlineViews([cell1.containerView!.view!], outlineColor: .darkGrayColor())

//: [Next](@next)
