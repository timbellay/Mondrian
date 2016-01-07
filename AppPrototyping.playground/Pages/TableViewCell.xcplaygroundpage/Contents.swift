//: [Previous](@previous)

import UIKit
import XCPlayground


let device = Device.iPhone6
let frame = device.frame()
let statusbar = StatusBar(frame: device.frame(), theme: .dark)

let cell1 = UITableViewCell()
cell1.textLabel?.text = "cell1"
let cell2 = UITableViewCell()
cell2.textLabel?.text = "cell2"
var cells = [cell1, cell2]

var feedView = FeedView(device: device, height: 500, cells: cells)
feedView.viewDidLoad()

var view = UIView(frame: device.frame())
XCPlaygroundPage.currentPage.liveView = view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

var sv = makeVerticalSV(view)
sv.addArrangedSubview(statusbar.view)
horizontalStrechToParentView(statusbar.view)
sv.addArrangedSubview(feedView.view!)

feedView.view!.frame
feedView.tableView!.frame
// ^^ still have frame issues with tableView

outlineViews([view], outlineColor: .whiteColor())

//: [Next](@next)
