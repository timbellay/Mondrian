//: [Previous](@previous)

import UIKit
import XCPlayground

public enum CellType {
	case Simple
}

public class Cell {
	public var view: View?
	public var members: [String : AnyObject]?
	public var memberData: [String : [AnyObject]]?
	public func addMember(keyName: String, value: AnyObject) {
		members?[keyName] = value
	}

	public init(device: Device, cellType: CellType) {
		switch cellType {
		case .Simple:
			let labelView = View(width: 200, height: 44, color: .clearColor())
			let leftView = View(width: 44, height: 44, color: .darkGrayColor())
			let rightView = View(width: 44, height: 44, color: .darkGrayColor())
			labelView.stick(leftView, direction: .Left)
			labelView.stick(rightView, direction: .Right)
			members = ["leftView" : leftView, "rightView" : rightView, "labelView" : labelView]
			
			let label = UILabel(text: "LABEL", font: Font.titleText.create(), textColor: .darkGrayColor(), labelColor: .clearColor())
			label.textAlignment = .Left
			labelView.stickViewInside(label)
			
			view = View(width: device.frame().width, height: 44, color: .lightGrayColor())
			view?.stickViewInside(labelView.superStackview!)
		}
	}
	
	public init(view: View, members: [String : AnyObject]?) {
		self.view = view
		self.members = members
	}
}

public class TableView: ScrollView {
	var subStackView: UIStackView?
	var tableViewHeightAnchor: CGFloat?
	var tableViewWidthAnchor: CGFloat?
	public var cells: [Cell]?

	public init(device: Device, width: CGFloat?, height: CGFloat?, cells: [Cell]?) {
		super.init(device: device, imageName: nil, scrollDirection: .Vertical, width: width, height: height)
		self.cells = cells
		view.backgroundColor = .purpleColor()
		//setup stackview
		let sv = makeVerticalSV(view)
		subStackView = sv
		setTheTable()
	}
	
	func setTheTable() {
		if let cellArray = cells {
			cellArray.forEach({
				if let v = $0.view {
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
let statusbar = StatusBar(frame: device.frame(), theme: .dark)

let cell1 = Cell(device: device, cellType: .Simple)
let cell2 = Cell(device: device, cellType: .Simple)

var tableView = TableView(device: device, width: nil, height: 300, cells: [cell1, cell2])

var containerView = UIView(frame: device.frame())
var sv = makeVerticalSV(containerView)
sv.addArrangedSubview(statusbar.view)
horizontalStrechToParentView(statusbar.view)
sv.addArrangedSubview(tableView.view)
tableView.view

XCPlaygroundPage.currentPage.liveView = containerView
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


outlineViews([containerView], outlineColor: .whiteColor())


//: [Next](@next)
