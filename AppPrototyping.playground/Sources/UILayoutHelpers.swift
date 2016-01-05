import UIKit

public func makeHorizontalSV(view: UIView) -> UIStackView {
	return makeSV(view, axis: .Horizontal)
}

public func makeVerticalSV(view: UIView) -> UIStackView {
	return makeSV(view, axis: .Vertical)
}

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

public func horizontalStrechToParentView(arr: UIView...) {
	var viewDict = [String: UIView]()
	var layoutConstraints = [NSLayoutConstraint]()
	for (ind, view) in arr.enumerate() {
		if let _ = view.superview { // Test to see if view has a superview before trying to add constraint.
			let viewName = "view\(ind)"
			viewDict.updateValue(view, forKey: viewName)
			layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat("|[\(viewName)]|", options: [], metrics: nil, views: viewDict)
		}
	}
	NSLayoutConstraint.activateConstraints(layoutConstraints)
}

public func setConstraints(visualLanguage: Array<String>, views: Dictionary<String, AnyObject>) {
	var layoutConstraints = [NSLayoutConstraint]()
	visualLanguage.forEach({
		layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat($0, options: [], metrics: nil, views: views)
	})
	NSLayoutConstraint.activateConstraints(layoutConstraints)
}