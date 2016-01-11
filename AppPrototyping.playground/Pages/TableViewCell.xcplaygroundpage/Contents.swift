//: [Previous](@previous)

import UIKit
import XCPlayground


//let device = Device.iPhone6
//let frame = device.frame()
//let statusbar = StatusBar(frame: device.frame(), theme: .dark)
//
//let cell1 = UITableViewCell()
//cell1.textLabel?.text = "cell1"
//let cell2 = UITableViewCell()
//cell2.textLabel?.text = "cell2"
//var cells = [cell1, cell2]
//
//var feedView = FeedView(device: device, height: 500, cells: cells)
//feedView.viewDidLoad()
//
//var view = UIView(frame: device.frame())
//XCPlaygroundPage.currentPage.liveView = view
//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
//
//var sv = makeVerticalSV(view)
//sv.addArrangedSubview(statusbar.view)
//horizontalStrechToParentView(statusbar.view)
//sv.addArrangedSubview(feedView.view!)


let view = View(width: 200, height: 44, color: .clearColor())
let leftView = View(width: 44, height: 44, color: .darkGrayColor())
let rightView = View(width: 44, height: 44, color: .darkGrayColor())

view.stick(leftView, direction: .Left)
view.stick(rightView, direction: .Right)

let label = UILabel(text: "LABEL", font: Font.titleText.create(), textColor: .darkGrayColor(), labelColor: .clearColor())
label.textAlignment = .Left
view.stickViewInside(label)

let containerView = View(width: 320, height: 50, color: .lightGrayColor())
let containerViewSV = makeVerticalSV(containerView)
containerViewSV.addArrangedSubview(view.superStackview!)
//containerView.stickViewInside(view.superStackview as! UIView)


XCPlaygroundPage.currentPage.liveView = containerView
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


//outlineViews([containerView], outlineColor: .whiteColor())

//: [Next](@next)
