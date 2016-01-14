import UIKit

public enum CellType {
	case Simple
}

public class Cell {
	public var containerView: ContainerView?
	public var members: [String : AnyObject]?
	public var memberData: [String : [AnyObject]]?
	public func addMember(keyName: String, value: AnyObject) {
		members?[keyName] = value
	}
	
	public init(device: Device, cellType: CellType) {
		let deviceFrame = device.frame()
		containerView = ContainerView(width: deviceFrame.width, height: 54, color: .whiteColor(), marginInset: 5)

		switch cellType {
		case .Simple:
			let imageView = UIView(width: 44, height: 44, color: .whiteColor())
			let labelView = ContainerView(width: 150, height: 44, color: .whiteColor(), marginInset: 0)
			let accessoryView = UIView(width: 44, height: 44, color: .whiteColor())
			let label = UILabel(text: "cell label", font: Font.titleText.create(), textColor: .blackColor(), labelColor: .whiteColor())
			labelView.stickSubviewToInsideMargin(.Left, subview: label, byAmount: 0)
			
			// Stick imageView.
			containerView?.stickSubviewToInsideMargin(.Left, subview: imageView, byAmount: 0)
			containerView?.stickSubviewToInsideMargin(.Top, subview: imageView, byAmount: 0)
			
			// Stick accessoryView.
			containerView?.stickSubviewToInsideMargin(.Right, subview: accessoryView, byAmount: 0)
			containerView?.stickSubviewToInsideMargin(.Top, subview: accessoryView, byAmount: 0)
			
			// Stick labelView to imageView.
			containerView?.stickSubviewToSubview(labelView.view!, direction: .Right, subview2: imageView, byAmount: 8, align: .CenterY)
			
			
			members = ["label" : labelView, "image" : imageView, "accessory" : accessoryView]
		}
	}
	
	public init(containerView: ContainerView, members: [String : AnyObject]?) {
		self.containerView = containerView
		self.members = members
	}
}
