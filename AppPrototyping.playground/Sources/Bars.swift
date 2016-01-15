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


public struct StatusBar {
	public var view = UIView(frame: .zero)
	var mainSV: UIStackView?
	var carrierSV: UIStackView?
	var circleSV: UIStackView?
	var outline: Bool = false
	var theme: Theme = .light
	var labels = [UILabel]()
	var carrierSignalStrength = 3 // range: 0 - 5.
	var batteryPercentage = 58 // range: 0 - 100.
	var navigationLabel = UILabel()
	public var navigation: String? {
		didSet {
			if let navString = navigation {
				if theme == .light {
					navigationLabel = UILabel(text: navString, font: Font.smalltext.create(), textColor: .blackColor(), labelColor: .whiteColor())
				} else {
					navigationLabel = UILabel(text: navString, font: Font.smalltext.create(), textColor: .whiteColor(), labelColor: .blackColor())
				}
				carrierSV?.hidden = true
			} else {
				carrierSV?.hidden = false
			}
		}
	}

	public init(frame: CGRect, theme: Theme) {
		let width = frame.size.width
		let height = CGFloat(20)
		view.frame = CGRectMake(0, 0, width, height)
		self.theme = theme
		let smallFont = Font.smalltext.create()
		let gray = Color.grayBackground.create()

		mainSV = makeHorizontalSV(view)
		carrierSV = makeHorizontalSV(mainSV!)
		circleSV = makeHorizontalSV(carrierSV!)

		// Signal strength circles.
		// Draw filled circle and get image.
		let filledCircle = UIBezierPath(arcCenter: CGPointMake(4, 4), radius: 3, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
		UIGraphicsBeginImageContext(CGSizeMake(8, 8))
		if theme == .light {
			view.backgroundColor = Color.grayBackground.create()
			UIColor.blackColor().setStroke()
			UIColor.blackColor().setFill()
		} else {
			view.backgroundColor = .clearColor()
			UIColor.whiteColor().setStroke()
			UIColor.whiteColor().setFill()
		}
		filledCircle.lineWidth = 1
		filledCircle.fill()
		filledCircle.stroke()
		let filledCircleImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		// Draw empty circle and get image.
		let emptyCircle = UIBezierPath(arcCenter: CGPointMake(4, 4), radius: 3, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
		UIGraphicsBeginImageContext(CGSizeMake(8, 8))
		if theme == .light {
			view.backgroundColor = gray
			UIColor.blackColor().setStroke()
		} else {
			view.backgroundColor = .clearColor()
			UIColor.whiteColor().setStroke()
		}
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
		
		if theme == .light {
			view.backgroundColor = gray
			UIColor.blackColor().setStroke()
			UIColor.blackColor().setFill()
		} else {
			view.backgroundColor = .clearColor()
			UIColor.whiteColor().setStroke()
			UIColor.whiteColor().setFill()
		}
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
		
		if theme == .light {
			labels.forEach({$0.textColor = .blackColor()})
		} else {
			labels.forEach({$0.textColor = .whiteColor()})
		}
	}
}

public struct NavigationBar {
	// TODO: ability to add search bar to the navBar.
	public var containerView: ContainerView?
	var backCarrot = UIView(width: 22, height: 22, color: Color.blueLink.create())
	var backLabel: UIView
	var titleLabel = UILabel()
	var rightNavItem: UIView
	
	public init(frame: CGRect, theme: Theme, title: String) {
		containerView = ContainerView(width: frame.width, height: 44, color: .orangeColor(), marginInset: 8)
		// Make bar elements.
		if theme == .light {
			backLabel = UILabel(text: "Back", font: Font.bodyText.create(), textColor: Color.blueLink.create(), labelColor: .whiteColor())
			titleLabel = UILabel(text: title, font: Font.bodyText.create(), textColor: .blackColor(), labelColor: .whiteColor())
			rightNavItem = UILabel(text: "Action", font: Font.bodyText.create(), textColor: Color.blueLink.create(), labelColor: .whiteColor())
			containerView?.view?.backgroundColor = .whiteColor()
		} else {
			backLabel = UILabel(text: "Back", font: Font.bodyText.create(), textColor: .whiteColor(), labelColor: .clearColor())
			titleLabel = UILabel(text: title, font: Font.bodyText.create(), textColor: .whiteColor(), labelColor: .clearColor())
			rightNavItem = UILabel(text: "Action", font: Font.bodyText.create(), textColor: .whiteColor(), labelColor: .clearColor())
			containerView?.view?.backgroundColor = .clearColor()
		}
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
	
	public init(frame: CGRect, theme: Theme) {
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

		if theme == .light {
			view.barTintColor = Color.grayBackground.create()
		} else {
			view.translucent = true
			view.barTintColor = .clearColor()
			view.setShadowImage(UIImage(), forToolbarPosition: .Any)
			buttons.forEach({$0.tintColor = .whiteColor()})
		}
	
		view.setItems([spacer, button0, spacer, button1, spacer, button2, spacer, button3, spacer], animated: true)
	}
}

public struct TabBar {
	public var view = UIView(frame: .zero)
	public var buttons = [UIBarButtonItem]()
	public var mainSV: UIStackView?
	
	public init(frame: CGRect, theme: Theme) {
		view.frame = CGRectMake(0, 0, frame.size.width, 44)
		mainSV = makeHorizontalSV(view)
		view.addSubview(mainSV!)
		
		if theme == .light {
			view.backgroundColor = Color.grayBackground.create()
	
		} else {
			view.backgroundColor = .clearColor()
		}
		
		let barButton0 = Button(theme: theme, imageName: "button", text: "Messaging", type: .Down)
		let barButton1 = Button(theme: theme, imageName: "button", text: "My Data", type: .Down)
		let barButton2 = Button(theme: theme, imageName: "button", text: "Info", type: .Down)
		let barButton3 = Button(theme: theme, imageName: "button", text: "Settings", type: .Down)
		mainSV?.addArrangedSubview(barButton0.view)
		mainSV?.addArrangedSubview(barButton1.view)
		mainSV?.addArrangedSubview(barButton2.view)
		mainSV?.addArrangedSubview(barButton3.view)
		
	
	}
}

public struct SearchBar {
	var view = UISearchBar()
	public init(frame: CGRect, theme: Theme) {
		if theme == .light {
			view.barTintColor = Color.grayBackground.create()
			view.tintColor = .blackColor()
		} else {
			view.barTintColor = .clearColor()
			view.tintColor = .whiteColor()
		}
		view.placeholder = "Search"
		view.showsCancelButton = true
	}
}
