//
//  Bars.swift
//
//
//  Created by Timothy Bellay on 12/6/15.
//
//

import UIKit

public extension UILabel {
	convenience init(text: String, font: UIFont, textColor: UIColor, labelColor: UIColor) {
		self.init()
		let labelAttr: NSDictionary = [
			NSFontAttributeName : font,
		]
		self.attributedText = NSAttributedString(string: text, attributes:  labelAttr as? [String : AnyObject])
		self.textColor = textColor
		self.backgroundColor = labelColor
		self.textAlignment = .Center
		self.numberOfLines = 0
		self.sizeToFit()
	}
}

public extension UIView {
	convenience init(width: CGFloat?, height: CGFloat?, color: UIColor?) {
		self.init()
		if color != nil {
			self.backgroundColor = color!
		} else {
			self.backgroundColor = .clearColor()
		}
		self.translatesAutoresizingMaskIntoConstraints = false
		
		// Setup view anchors.
		if let wAnchor = width {
			self.widthAnchor.constraintEqualToConstant(wAnchor).active = true
		} else {
			self.widthAnchor.constraintEqualToConstant(44).active = true
			
		}
		if let hAnchor = height {
			self.heightAnchor.constraintEqualToConstant(hAnchor).active = true
			
		} else {
			self.heightAnchor.constraintEqualToConstant(44).active = true
		}
	}
}

extension UIImage {
	class func imageWithColor(color: UIColor) -> UIImage {
		let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextFillRect(context, rect)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image
	}
}

public struct StatusBar {
	public var view = UIView(frame: .zero)
	var mainSV: UIStackView?
	var carrierSV: UIStackView?
	var circleSV: UIStackView?
	var outline: Bool = false
	var appearance: Appearance
	var labels = [UILabel]()
	var carrierSignalStrength = 3 // range: 0 - 5.
	var batteryPercentage = 58 // range: 0 - 100.
	var navigationLabel = UILabel()
	public var navigation: String? {
		didSet {
			if let navString = navigation {
				if appearance.theme == .Light {
					navigationLabel = UILabel(text: navString, font: Font.SmallText.create(), textColor: appearance.textColor(), labelColor: appearance.labelColor())
				} else {
					navigationLabel = UILabel(text: navString, font: Font.SmallText.create(), textColor: appearance.textColor(), labelColor: appearance.labelColor())
				}
				carrierSV?.hidden = true
			} else {
				carrierSV?.hidden = false
			}
		}
	}

	public init(frame: CGRect, appearance: Appearance) {
		let width = frame.size.width
		let height = CGFloat(20)
		view.frame = CGRectMake(0, 0, width, height)
		view.backgroundColor = appearance.labelColor()
		self.appearance = appearance
		let smallFont = Font.SmallText.create()

		// TODO: replace horizontal stackViews and build with UILayoutGuide.
		mainSV = makeHorizontalSV(view)
		carrierSV = makeHorizontalSV(mainSV!)
		circleSV = makeHorizontalSV(carrierSV!)

		// Signal strength circles.
		// Draw filled circle and get image.
		let filledCircle = UIBezierPath(arcCenter: CGPointMake(4, 4), radius: 3, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
		UIGraphicsBeginImageContext(CGSizeMake(8, 8))
		appearance.setStrokeAndFill()
		
		filledCircle.lineWidth = 1
		filledCircle.fill()
		filledCircle.stroke()
		let filledCircleImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		// Draw empty circle and get image.
		let emptyCircle = UIBezierPath(arcCenter: CGPointMake(4, 4), radius: 3, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
		UIGraphicsBeginImageContext(CGSizeMake(8, 8))
		appearance.setStrokeAndFill()

		emptyCircle.lineWidth = 1
		emptyCircle.stroke()
		let emptyCircleImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
	
		let circleView0 = UIImageView(image: filledCircleImage)
		let circleView1 = UIImageView(image: filledCircleImage)
		let circleView2 = UIImageView(image: filledCircleImage)
		let circleView3 = UIImageView(image: emptyCircleImage)
		let circleView4 = UIImageView(image: emptyCircleImage)
		circleSV!.addArrangedSubview(circleView0)
		circleSV!.addArrangedSubview(circleView1)
		circleSV!.addArrangedSubview(circleView2)
		circleSV!.addArrangedSubview(circleView3)
		circleSV!.addArrangedSubview(circleView4)
		
		// Carrier Label
		let carrierLabel = UILabel(text: "T-Mobile LTE", font: smallFont, textColor: .clearColor(), labelColor: .clearColor())
		carrierSV!.addArrangedSubview(carrierLabel)
		labels.append(carrierLabel)
		
		// Time Label
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "HH:mm"
		dateFormatter.timeStyle = .ShortStyle
		let timeLabel = UILabel(text: dateFormatter.stringFromDate(NSDate()), font: smallFont, textColor: .clearColor(), labelColor: .clearColor())
		mainSV!.addArrangedSubview(timeLabel)
		labels.append(timeLabel)

		// Battery percentage label
		let batteryLabel = UILabel(text: "\(batteryPercentage)%", font: smallFont, textColor: .clearColor(), labelColor: .clearColor())
		let batterySV = makeHorizontalSV(mainSV!)
		batterySV.addArrangedSubview(batteryLabel)
		labels.append(batteryLabel)
		
		// Battery percentage bar
		UIGraphicsBeginImageContext(CGSizeMake(30, 20))
		let batteryBodyWidth = 20 // pts.
		let batteryBodyPath = UIBezierPath(rect: CGRectMake(2.5, 5, CGFloat(batteryBodyWidth), 10))
		let batteryCapPath = UIBezierPath(rect: CGRectMake(CGFloat(batteryBodyWidth + 2), 7, 2.5, 5))
		let batteryRemainingPath = UIBezierPath(rect: CGRectMake(3.5, 6, CGFloat((batteryBodyWidth - 2) * batteryPercentage / 100), 8))
		
		view.backgroundColor = appearance.labelColor()
		appearance.setStrokeAndFill()
		batteryBodyPath.lineWidth = 1
		batteryCapPath.lineWidth = 1
		batteryBodyPath.stroke()
		batteryCapPath.fill()
		if batteryPercentage <= 20 {
			UIColor.redColor().setFill()
		}
		batteryRemainingPath.fill()
		
		let batteryImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		let batteryView = UIImageView(image: batteryImage)
		batterySV.addArrangedSubview(batteryView)
		
		labels.forEach({$0.textColor = appearance.textColor()})
		
	}
}

public struct NavigationBar {
	// TODO: ability to add search bar to the navBar.
	public var containerView: ContainerView?
	var backCarrot = UIView(width: 11, height: 22, color: Color.BlueLink.create())
	var backLabel: UIView
	var titleLabel = UILabel()
	var rightNavItem: UIView
	
	public init(frame: CGRect, appearance: Appearance, title: String) {
		containerView = ContainerView(width: frame.width, height: 44, color: .orangeColor(), marginInset: 8)
		
		// Make bar elements.
		backLabel = UILabel(text: "Back", font: Font.BodyText.create(), textColor: appearance.textColor(), labelColor: appearance.labelColor())
		titleLabel = UILabel(text: title, font: Font.BodyText.create(), textColor: appearance.textColor(), labelColor: appearance.labelColor())
		rightNavItem = UILabel(text: "Action", font: Font.BodyText.create(), textColor: appearance.textColor(), labelColor: appearance.labelColor())
		containerView?.view?.backgroundColor = appearance.labelColor()
		backCarrot.backgroundColor = appearance.textColor()
		
		// Turn off autoResizingMask...
		backCarrot.translatesAutoresizingMaskIntoConstraints = false
		backLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		rightNavItem.translatesAutoresizingMaskIntoConstraints = false
		
		// Add bar elements to containerView.
		containerView?.stickSubviewToInsideMargin(.Left, subview: backCarrot, byAmount: 0)
		containerView?.centerSubviewYInside(backCarrot)
		containerView?.stickSubviewToSubview(backLabel, direction: .Right, subview2: backCarrot, byAmount: 4, align: .CenterY)
		
		containerView?.stickSubviewToInsideMargin(.Right, subview: rightNavItem, byAmount: 0)
		containerView?.centerSubviewYInside(rightNavItem)
		containerView?.centerSubviewInside(titleLabel)
		
	}
}

public struct ToolBar {
	public var view = UIToolbar()
	public var buttons = [UIBarButtonItem]()
	
	public init(frame: CGRect, appearance: Appearance) {
		view.frame = CGRectMake(0, 0, frame.size.width, 44)

		let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
		let button0 = UIBarButtonItem(barButtonSystemItem: .Edit, target: nil, action: nil)
		buttons.append(button0)
		let button1 = UIBarButtonItem(barButtonSystemItem: .Add, target: nil, action: nil)
		buttons.append(button1)
		let button2 = UIBarButtonItem(barButtonSystemItem: .Trash, target: nil, action: nil)
		buttons.append(button2)
		let button3 = UIBarButtonItem(barButtonSystemItem: .Search, target: nil, action: nil)
		buttons.append(button3)

		view.barTintColor = appearance.labelColor()
//		view.setShadowImage(UIImage(), forToolbarPosition: .Any) // Clear the shadow image.
		view.translucent = false // Bars are defaulted to translucent and gaussian blurred.
		buttons.forEach({$0.tintColor = appearance.textColor()})
		
		view.setItems([spacer, button0, spacer, button1, spacer, button2, spacer, button3, spacer], animated: true)
	}
}

public struct TabBar {
	public var view = UIView(frame: .zero)
	public var buttons = [UIBarButtonItem]()
	public var mainSV: UIStackView?
	
	public init(frame: CGRect, appearance: Appearance) {
		view.frame = CGRectMake(0, 0, frame.size.width, 44)
		mainSV = makeHorizontalSV(view)
		view.addSubview(mainSV!)
		view.backgroundColor = appearance.labelColor()
		
		let barButton0 = Button(appearance: appearance, imageName: "button", text: "Messaging", type: .Down)
		let barButton1 = Button(appearance: appearance, imageName: "button", text: "My Data", type: .Down)
		let barButton2 = Button(appearance: appearance, imageName: "button", text: "Info", type: .Down)
		let barButton3 = Button(appearance: appearance, imageName: "button", text: "Settings", type: .Down)
		mainSV?.addArrangedSubview(barButton0.view)
		mainSV?.addArrangedSubview(barButton1.view)
		mainSV?.addArrangedSubview(barButton2.view)
		mainSV?.addArrangedSubview(barButton3.view)
		
	
	}
}

public struct SearchBar {
	var view = UISearchBar()
	public init(frame: CGRect, appearance: Appearance) {
		view.barTintColor = appearance.labelColor()
		view.tintColor = appearance.textColor()
		view.backgroundImage = UIImage.imageWithColor(appearance.labelColor())
		view.placeholder = "search"
		view.showsCancelButton = true
		
		if appearance.theme == .Light {
			UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).backgroundColor = .lightGrayColor()
		} // To prevent the search bar text background to be indistinguishable from the white bar background.
	}
}
