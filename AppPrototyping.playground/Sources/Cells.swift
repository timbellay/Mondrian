import UIKit

public enum CellType {
	case Simple
}

public class Cell {
	public var containerView: ContainerView?
	public var members = [String : AnyObject]()
	public var memberProperties = [String : [String]]()

	public func addMember(keyName: String, value: AnyObject) {
		members[keyName] = value
	}
	
	public init(device: Device, cellType: CellType, appearance: Appearance) {
		let deviceFrame = device.frame()
		containerView = ContainerView(width: deviceFrame.width, height: 44, color: appearance.labelColor(), marginInset: 8)

		switch cellType {
		// TODO: Add other default types of cells in case statement here.
		case .Simple:
			let lineView = UIView(width: deviceFrame.width - 44, height: 1, color: appearance.textColor())
			containerView?.stickSubviewToInsideMargin(.Bottom, subview: lineView, byAmount: 8)
			containerView?.stickSubviewToInsideMargin(.Right, subview: lineView, byAmount: 8)
			
			let imageView = UIView(width: 29, height: 29, color: appearance.textColor())
			imageView.layer.borderColor = appearance.textColor().CGColor
			imageView.layer.cornerRadius = 8
			let accessoryView = UIView(width: 29, height: 29, color: appearance.textColor())
			accessoryView.layer.borderColor = appearance.textColor().CGColor
			accessoryView.layer.cornerRadius = 8
			let label = UILabel(text: "cell label", font: Font.BodyText.create(), textColor: appearance.textColor(), labelColor: appearance.labelColor())
			print("label created: \(label)")
			label.translatesAutoresizingMaskIntoConstraints = false
			
			// Stick imageView to left margin in containerView
			containerView?.stickSubviewToInsideMargin(.Left, subview: imageView, byAmount: 8)
			containerView?.stickSubviewToInsideMargin(.Top, subview: imageView, byAmount: 0)
			
			// Stick accessoryView to right margin in containerView
			containerView?.stickSubviewToInsideMargin(.Right, subview: accessoryView, byAmount: -8)
			containerView?.stickSubviewToInsideMargin(.Top, subview: accessoryView, byAmount: 0)
			
			// Stick label to right side of imageView.
			containerView?.stickSubviewToSubview(label, direction: .Right, subview2: imageView, byAmount: 16, align: .CenterY)
			
			members = ["label" : label, "image" : imageView, "accessory" : accessoryView]
			print("label found in array: \(members["label"])")
			
		}
	}
	
	public func setupCellWithData() {
		let keys = memberProperties.keys
//		print("keys: \(keys)")
		keys.forEach({
			print("member: \(members[$0]) = member property: \(memberProperties[$0]) ")
//			print("member property value: \(members[$0].getValue
			members[$0]?.setNeedsDisplay()
		})
		
	}
	
	public init(containerView: ContainerView, members: [String : AnyObject]) {
		self.containerView = containerView
		self.members = members
	}
}
