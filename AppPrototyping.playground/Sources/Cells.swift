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
	
	public init(device: Device, cellType: CellType) {
		let deviceFrame = device.frame()
		containerView = ContainerView(width: deviceFrame.width, height: 44, color: .whiteColor(), marginInset: 8)

		switch cellType {
		// TODO: Add other default types of cells in case statement here.
		case .Simple:
			var imageView = UIView(width: 29, height: 29, color: .whiteColor())
			var accessoryView = UIView(width: 29, height: 29, color: .whiteColor())
			var label = UILabel(text: "cell label", font: Font.bodyText.create(), textColor: .blackColor(), labelColor: .whiteColor())
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

			if var text = label.attributedText {
				memberProperties = ["label" : ["text"]]
			}
			
			
		}
	}
	
	public func setupCellWithData() {
		let keys = memberProperties.keys
//		print("keys: \(keys)")
		keys.forEach({
			print("member: \(members[$0]) = member property: \(memberProperties[$0]) ")
			let array = memberProperties[$0]
			
//			print("member property value: \(members[$0].getValue
			members[$0]?.setNeedsDisplay()
		})
		
	}
	
	public init(containerView: ContainerView, members: [String : AnyObject]) {
		self.containerView = containerView
		self.members = members
	}
}
