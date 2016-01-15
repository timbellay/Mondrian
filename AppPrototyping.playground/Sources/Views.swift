import UIKit

public func makeHorizontalSV(view: UIView) -> UIStackView {
	return makeSV(view, axis: .Horizontal)
}

public func makeVerticalSV(view: UIView) -> UIStackView {
	return makeSV(view, axis: .Vertical)
}

/**
Adds a UIStackView as a subview to a view and its layout constraints to fill the view.
*/
public func makeSV(view: UIView, axis: UILayoutConstraintAxis) -> UIStackView {
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

public enum Margin {
	case Left, Right, Top, Bottom
}

public enum Align {
	case Left, Right, Top, Bottom, CenterX, CenterY
}

public class ContainerView {
	public var view: UIView?
	var viewWidthAnchor: CGFloat?
	var viewHeightAnchor: CGFloat?
	
	public var superStackview: UIStackView?
	public var subStackview: UIStackView?

	var subviews: [UIView]?
	let marginLayout = UILayoutGuide()
	let marginInset: CGFloat = 8
	
	public init(width: CGFloat, height: CGFloat, color: UIColor?, marginInset: CGFloat) {
		
		if color != nil {
			view = UIView(width: width, height: height, color: color)
		} else {
			view = UIView(width: width, height: height, color: nil)
		}
		viewWidthAnchor = width
		viewHeightAnchor = height
		
		view?.translatesAutoresizingMaskIntoConstraints = false

		view?.addLayoutGuide(marginLayout)
		view?.layoutMargins = UIEdgeInsets(top: marginInset, left: marginInset,
			bottom: marginInset, right: marginInset)
		// Set marginLayout guide to match view's margins.
		var constraints = [NSLayoutConstraint]()
		constraints.append(marginLayout.centerXAnchor.constraintEqualToAnchor(view?.centerXAnchor))
		constraints.append(marginLayout.centerYAnchor.constraintEqualToAnchor(view?.centerYAnchor))
		constraints.append(marginLayout.widthAnchor.constraintEqualToAnchor(view?.widthAnchor, constant: -2 * marginInset))
		constraints.append(marginLayout.heightAnchor.constraintEqualToAnchor(view?.heightAnchor, constant: -2 * marginInset))
		NSLayoutConstraint.activateConstraints(constraints)
	}
		
	public func stickSubviewToInsideMargin(margin: Margin, subview: UIView, byAmount: CGFloat) {
		view?.addSubview(subview)
		switch margin {
		case .Left:
			NSLayoutConstraint(item: subview, attribute: .Left, relatedBy: .Equal, toItem: marginLayout, attribute: .Left, multiplier: 1, constant: byAmount).active = true
		case .Right:
			NSLayoutConstraint(item: subview, attribute: .Right, relatedBy: .Equal, toItem: marginLayout, attribute: .Right, multiplier: 1, constant: byAmount).active = true
		case .Top:
			NSLayoutConstraint(item: subview, attribute: .Top, relatedBy: .Equal, toItem: marginLayout, attribute: .Top, multiplier: 1, constant: byAmount).active = true
		case .Bottom:
			NSLayoutConstraint(item: subview, attribute: .Bottom, relatedBy: .Equal, toItem: marginLayout, attribute: .Bottom, multiplier: 1, constant: byAmount).active = true
		break
		}
	}

	public func centerSubviewXInside(subview: UIView) {
		NSLayoutConstraint(item: subview, attribute: .CenterX, relatedBy: .Equal, toItem: view!, attribute: .CenterX, multiplier: 1, constant: 0).active = true
	}
	
	public func centerSubviewYInside(subview: UIView) {
		NSLayoutConstraint(item: subview, attribute: .CenterY, relatedBy: .Equal, toItem: view!, attribute: .CenterY, multiplier: 1, constant: 0).active = true
	}

	
	public func centerSubviewInside(subview: UIView) {
		view?.addSubview(subview)
		centerSubviewXInside(subview)
		centerSubviewYInside(subview)
	}
	
	public func stickSubviewToSubview(subview1: UIView, direction: Direction, subview2: UIView, byAmount: CGFloat, align: Align) {
		view?.addSubview(subview1)
		switch direction {
		case .Up:
			NSLayoutConstraint(item: subview1, attribute: .Bottom, relatedBy: .Equal, toItem: subview2, attribute: .Top, multiplier: 1, constant: byAmount).active = true
		case .Down:
			NSLayoutConstraint(item: subview1, attribute: .Top, relatedBy: .Equal, toItem: subview2, attribute: .Bottom, multiplier: 1, constant: byAmount).active = true
		case .Left:
			NSLayoutConstraint(item: subview1, attribute: .Right, relatedBy: .Equal, toItem: subview2, attribute: .Left, multiplier: 1, constant: byAmount).active = true
		case .Right:
			NSLayoutConstraint(item: subview1, attribute: .Left, relatedBy: .Equal, toItem: subview2, attribute: .Right, multiplier: 1, constant: byAmount).active = true
		}
		
		switch align {
		case .CenterX:
			NSLayoutConstraint(item: subview1, attribute: .CenterX, relatedBy: .Equal, toItem: subview2, attribute: .CenterX, multiplier: 1, constant: 0).active = true
		case .CenterY:
			NSLayoutConstraint(item: subview1, attribute: .CenterY, relatedBy: .Equal, toItem: subview2, attribute: .CenterY, multiplier: 1, constant: 0).active = true
		case .Left:
			NSLayoutConstraint(item: subview1, attribute: .Left, relatedBy: .Equal, toItem: subview2, attribute: .Left, multiplier: 1, constant: 0).active = true
		case .Right:
			NSLayoutConstraint(item: subview1, attribute: .Right, relatedBy: .Equal, toItem: subview2, attribute: .Right, multiplier: 1, constant: 0).active = true
		case .Top:
			NSLayoutConstraint(item: subview1, attribute: .Top, relatedBy: .Equal, toItem: subview2, attribute: .Top, multiplier: 1, constant: 0).active = true
		case .Bottom:
			NSLayoutConstraint(item: subview1, attribute: .Bottom, relatedBy: .Equal, toItem: subview2, attribute: .Bottom, multiplier: 1, constant: 0).active = true
		}
	}
	
	// TODO: Rethink and refactor stackview code below. TB.
	
//	func setupSuperStackView(direction: Direction) {
//		if superStackview == nil {
//			superStackview = UIStackView(frame: .zero)
//			superStackview?.translatesAutoresizingMaskIntoConstraints = false
//			superStackview?.alignment = .Center
//			superStackview?.distribution = .EqualCentering
//			superStackview?.layoutMarginsRelativeArrangement = true
//			switch direction {
//			case .Left, .Right:
//				superStackview?.axis = .Horizontal
//			case .Up, .Down:
//				superStackview?.axis = .Vertical
//			}
//			superStackview?.addArrangedSubview(view!)
//		}
//	}
//	
//	func setupSubStackView() {
//		if subStackview == nil {
//			subStackview = makeSV(view!, axis: .Vertical)
//		}
//	}
//	
//	func findViewInStackView(view: UIView, stackview: UIStackView?) -> Int? {
//		var ind: Int? = nil
//		if let subviews = stackview?.arrangedSubviews {
//			for (i, arrangedView) in subviews.enumerate() {
//				if arrangedView == view {
//					ind = i
//				}
//			}
//		}
//		return ind
//	}
//	
//	func removeFromStackView(subview: UIView) {
//		unstick(subview, stackview: superStackview)
//		unstick(subview, stackview: subStackview)
//	}
//	
//	func unstick(subview: UIView, stackview: UIStackView?) {
//		stackview?.removeArrangedSubview(subview)
//	}
//	
//	public func stack(subview: UIView, direction: Direction) {
//		removeFromStackView(subview)
//		setupSuperStackView(direction)
//		if let ind = findViewInStackView(view!, stackview: superStackview) {
//			switch direction {
//			case .Left, .Up:
//				superStackview?.insertArrangedSubview(subview, atIndex: ind) // Except that expected arg type is UInt.
//			case .Right, .Down:
//				superStackview?.insertArrangedSubview(subview, atIndex: ind + 1)  // Except that expected arg type is UInt.
//			}
//		} else {
//			print("Warning View.self was not found in stackview.")
//		}
//	}

	
}

