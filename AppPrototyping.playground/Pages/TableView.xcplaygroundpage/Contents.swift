//: [Previous](@previous)

import UIKit
import XCPlayground



let device = Device.iPhone5s
let frame = device.frame()
let appearance = Appearance(theme: .Light, textColor: nil, labelColor: nil)
let statusbar = StatusBar(frame: device.frame(), appearance: appearance)
let navbar = NavigationBar(frame: frame, theme: .Light, title: "Simple Table")

let cell1 = Cell(device: device, cellType: .Simple)
let cell2 = Cell(device: device, cellType: .Simple)
cell1.containerView?.view?.frame
cell1.containerView?.view?.frame = CGRectMake(0, 0, frame.width, 100)
cell1.containerView?.view?.frame

var tableView = TableView(device: device, width: nil, height: device.frame().height - 64, cells: [cell1, cell2])

var containerView = UIView(frame: device.frame())
var sv = makeVerticalSV(containerView)
sv.addArrangedSubview(statusbar.view)
horizontalStrechToParentView(statusbar.view)
sv.addArrangedSubview(navbar.containerView!.view!)
sv.addArrangedSubview(tableView.view)
tableView.view

XCPlaygroundPage.currentPage.liveView = containerView
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


outlineViews([containerView], outlineColor: .blueColor())


//: [Next](@next)
