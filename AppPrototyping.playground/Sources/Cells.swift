import UIKit

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
			let imageView = View(width: 44, height: 44, color: .whiteColor())
			let labelView = View(width: 200, height: 44, color: .whiteColor())
			imageView.stick(labelView, direction: .Right)
			let label = UILabel(text: "cell label", font: Font.titleText.create(), textColor: .blackColor(), labelColor: .whiteColor())
			labelView.stickViewInside(label)
			let accessoryView = View(width: 44, height: 44, color: .whiteColor())
			view = View(width: device.frame().width, height: 44, color: .whiteColor())
			let containerSV = makeHorizontalSV(view!)
			containerSV.addArrangedSubview(imageView.superStackview!)
			containerSV.addArrangedSubview(accessoryView)
			members = ["label" : labelView, "image" : imageView, "accessory" : accessoryView]
		}
	}
	
	public init(view: View, members: [String : AnyObject]?) {
		self.view = view
		self.members = members
	}
}
