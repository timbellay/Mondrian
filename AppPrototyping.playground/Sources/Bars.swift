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
// TODO: extend to include outlineViews method from below. TB.

//	func centerInSuperview() {
//		self.centerHorizontallyInSuperview()
//		self.centerVerticallyInSuperview()
//	}
//	
//	func centerHorizontallyInSuperview(){
//		let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: self.superview, attribute: .CenterX, multiplier: 1, constant: 0)
//		self.superview?.addConstraint(c)
//	}
//	
//	func centerVerticallyInSuperview(){
//		let c: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: self.superview, attribute: .CenterY, multiplier: 1, constant: 0)
//		self.superview?.addConstraint(c)
//	}
	
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
	
	public var view = UIView(frame: .zero)
	var mainSV: UIStackView?
	var titleLabel = UILabel()
	public var leftNavItem: UIView
	public var rightNavItem: UIView
	public var title: String? {
		didSet {
			titleLabel.text = title
		}
	}
	
	public init(frame: CGRect, theme: Theme, title: String) {
		view.frame = CGRectMake(0, 0, frame.size.width, 44)
		self.title = title
		
		mainSV = makeHorizontalSV(view)
		view.addSubview(mainSV!)
		let gray = Color.grayBackground.create()
		if theme == .light {
			titleLabel = UILabel(text: title, font: Font.titleText.create(), textColor: .blackColor(), labelColor: gray)
			leftNavItem = UILabel(text: "<Back", font: Font.titleText.create(), textColor: .blackColor(), labelColor: gray)
			rightNavItem = UILabel(text: "Forward>", font: Font.titleText.create(), textColor: .blackColor(), labelColor: gray)
			view.backgroundColor = gray
		} else {
			titleLabel = UILabel(text: title, font: Font.titleText.create(), textColor: .whiteColor(), labelColor: .clearColor())
			leftNavItem = UILabel(text: "<Back", font: Font.titleText.create(), textColor: .whiteColor(), labelColor: .clearColor())
			rightNavItem = UILabel(text: "Settings", font: Font.titleText.create(), textColor: .whiteColor(), labelColor: .clearColor())
			view.backgroundColor = .clearColor()
		}
		
//		leftNavItem.textAlignment = .Left
//		rightNavItem.textAlignment = .Right
		mainSV!.addArrangedSubview(titleLabel)
		mainSV!.insertArrangedSubview(leftNavItem, atIndex: 0)
		mainSV!.addArrangedSubview(rightNavItem)
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
	
	public init(frame: CGRect, theme: Theme) {
		view.frame = CGRectMake(0, 0, frame.size.width, 44)
		if theme == .light {
			view.backgroundColor = Color.grayBackground.create()
		} else {
			view.backgroundColor = .clearColor()
		}
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.borderColor = UIColor.redColor().CGColor
		view.layer.borderWidth = 3
						
		let barButton0 = UITabBarItem(tabBarSystemItem: .More, tag: 0)
//		let barButton1 = UITabBarItem(tabBarSystemItem: .Favorites, tag: 1)
//		let barButton2 = UITabBarItem(tabBarSystemItem: .Featured, tag: 2)
//		let barButton3 = UITabBarItem(tabBarSystemItem: .TopRated, tag: 3)
		
		let imageView = UIImageView(image: barButton0.image)
		imageView.frame = CGRectMake(0, 0, 44, 44)
		imageView.backgroundColor = .purpleColor()
		print("image view frame: \(imageView.frame)")
		barButton0.title = "Test"

		view.addSubview(imageView)
	
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

public func makeHorizontalSV(view: UIView) -> UIStackView {
  return makeSV(view, axis: .Horizontal)
}

public func makeVerticalSV(view: UIView) -> UIStackView {
	return makeSV(view, axis: .Vertical)
}

func makeSV(view: UIView, axis: UILayoutConstraintAxis) -> UIStackView {
	let stackView = UIStackView(frame: .zero)
	stackView.translatesAutoresizingMaskIntoConstraints = false
	stackView.axis = axis
	stackView.alignment = .Center
	stackView.distribution = .EqualCentering
	stackView.layoutMarginsRelativeArrangement = true
	
	var layoutConstraints = [NSLayoutConstraint]()
	let views = ["stackView" : stackView]
	
	if let v = view as? UIStackView {
		v.addArrangedSubview(stackView)
	} else {
		// if the parent view is not a stackview then we can set
		view.addSubview(stackView)
		layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("|[stackView]|", options: [], metrics: nil, views: views)
	}
	layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[stackView]|", options: [], metrics: nil, views: views)
	NSLayoutConstraint.activateConstraints(layoutConstraints)
	
	return stackView
}