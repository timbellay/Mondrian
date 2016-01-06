//
//  UILayoutHelpers.swift
//
//
//  Created by Timothy Bellay on 01/05/16.
//
//

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

public func outlineViews(views: [UIView], outlineColor: UIColor) {
	// TODO: Color horizontal and vertical stackviews differently, i.e. blue and red.
	views.forEach({
		if let sv = $0 as? UIStackView {
			let pb = sv.superview
			let outlineView = UIView(frame: sv.bounds)
			outlineView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.15)
			outlineView.layer.borderColor = UIColor.redColor().CGColor
			outlineView.layer.borderWidth = 2
			pb?.addSubview(outlineView)
			print("adding stackview outline: \(outlineView) to superview: \(pb)")
		} else {
			$0.layer.borderWidth = 1
			$0.layer.borderColor = outlineColor.CGColor
			print("adding view outline")
		}
		let subViews = $0.subviews
		outlineViews(subViews, outlineColor: outlineColor)
	})
}

public var GlobalMainQueue: dispatch_queue_t {
	return dispatch_get_main_queue()
}

public func wait(seconds: Double, perform: ()->() ) {
	let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
	dispatch_after(delayTime, GlobalMainQueue, { () -> Void in
//		UIView.animateWithDuration(0.5) { () -> Void in
//			//        stackView.axis = .Vertical
//			screen.view.frame = CGRectMake(0, 0, 480, 320)
//		}
		
		perform()
	})

}


