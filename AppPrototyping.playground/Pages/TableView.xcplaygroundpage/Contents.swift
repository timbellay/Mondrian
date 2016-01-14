//: [Previous](@previous)

import UIKit
import XCPlayground


public class TableView: ScrollView {
	var subStackView: UIStackView?
	var tableViewHeightAnchor: CGFloat?
	var tableViewWidthAnchor: CGFloat?
	public var cells: [Cell]?

	public init(device: Device, width: CGFloat?, height: CGFloat?, cells: [Cell]?) {
		super.init(device: device, imageName: nil, scrollDirection: .Vertical, width: width, height: height)
		self.cells = cells
		view.backgroundColor = .clearColor()
		//setup stackview
		let sv = makeVerticalSV(view)
		subStackView = sv
		setTheTable()
	}
	
	func setTheTable() {
		if let cellArray = cells {
			cellArray.forEach({
				if let v = $0.containerView?.view! {
				subStackView?.addArrangedSubview(v)
				print("Adding cell view \(v) to stackview")
				}
			})
		}
	
	}
	
	public func addCell(cell: Cell) {
		cells?.append(cell)
	}
}

let device = Device.iPhone5s
let frame = device.frame()
let statusbar = StatusBar(frame: device.frame(), theme: .light)

let cell1 = Cell(device: device, cellType: .Simple)
let cell2 = Cell(device: device, cellType: .Simple)

var tableView = TableView(device: device, width: nil, height: device.frame().height - 20, cells: [cell1, cell2])

var containerView = UIView(frame: device.frame())
var sv = makeVerticalSV(containerView)
sv.addArrangedSubview(statusbar.view)
horizontalStrechToParentView(statusbar.view)
sv.addArrangedSubview(tableView.view)
tableView.view

XCPlaygroundPage.currentPage.liveView = containerView
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


outlineViews([containerView], outlineColor: .blueColor())


//: [Next](@next)
