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


public class View: UIView {
	public var superStackview: UIStackView?
	public var subStackview: UIStackView?
	var viewWidthAnchor: CGFloat?
	var viewHeightAnchor: CGFloat?
	
	public init(width: CGFloat?, height: CGFloat?, color: UIColor?) {
		super.init(frame: .zero)
		if color != nil {
			backgroundColor = color!
		} else {
			backgroundColor = .clearColor()
		}
		translatesAutoresizingMaskIntoConstraints = false
		
		// Setup view anchors.
		if let wAnchor = width {
			widthAnchor.constraintEqualToConstant(wAnchor).active = true
			viewWidthAnchor = wAnchor
		} else {
			widthAnchor.constraintEqualToConstant(44).active = true
			viewWidthAnchor = 44
		}
		if let hAnchor = height {
			heightAnchor.constraintEqualToConstant(hAnchor).active = true
			viewHeightAnchor = hAnchor
		} else {
			heightAnchor.constraintEqualToConstant(44).active = true
			viewHeightAnchor = 44
		}
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupSuperStackView(direction: Direction) {
		if superStackview == nil {
			superStackview = UIStackView(frame: .zero)
			superStackview?.translatesAutoresizingMaskIntoConstraints = false
			superStackview?.alignment = .Center
			superStackview?.distribution = .EqualCentering
			superStackview?.layoutMarginsRelativeArrangement = true
			switch direction {
			case .Left, .Right:
				superStackview?.axis = .Horizontal
			case .Up, .Down:
				superStackview?.axis = .Vertical
			}
			superStackview?.addArrangedSubview(self)
		}
	}
	
	func setupSubStackView() {
		if subStackview == nil {
			subStackview = makeSV(self, axis: .Vertical)
		}
	}
	
	func findViewInStackView(view: UIView, stackview: UIStackView?) -> Int? {
		var ind: Int? = nil
		if let subviews = stackview?.arrangedSubviews {
			for (i, arrangedView) in subviews.enumerate() {
				if arrangedView == view {
					ind = i
				}
			}
		}
		return ind
		
	}
	
	func removeFromStackView(subview: UIView) {
		unstick(subview, stackview: superStackview)
		unstick(subview, stackview: subStackview)
	}
	
	func unstick(subview: UIView, stackview: UIStackView?) {
		stackview?.removeArrangedSubview(subview)
	}
	
	public func stick(subview: UIView, direction: Direction) {
		removeFromStackView(subview)
		setupSuperStackView(direction)
		if let ind = findViewInStackView(self, stackview: superStackview) {
			switch direction {
			case .Left, .Up:
				superStackview?.insertArrangedSubview(subview, atIndex: ind) // Except that expected arg type is UInt.
			case .Right, .Down:
				superStackview?.insertArrangedSubview(subview, atIndex: ind + 1)  // Except that expected arg type is UInt.
			}
		} else {
			print("Warning View.self was not found in stackview.")
		}
	}
	
	public func stickViewInside(subview: UIView) {
		removeFromStackView(subview)
		if subStackview == nil {
			setupSubStackView()
			subStackview?.addArrangedSubview(subview)
		}
	}
	
}
