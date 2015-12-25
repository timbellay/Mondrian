//
//  Appearance.swift
//
//
//  Created by Timothy Bellay on 12/6/15.
//
//

import UIKit

public enum Color {
	case darkText, lightText, blueLink, grayBackground, grayLine, pink, clear
	
	public func create() -> UIColor {
		switch self {
		case darkText:
			return UIColor.darkTextColor()
		case lightText:
			return UIColor.lightTextColor()
		case blueLink:
			return UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
		case grayBackground:
			return UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
		case grayLine:
			return UIColor(red: 206/255, green: 206/255, blue: 210/255, alpha: 1)
		case pink:
			return UIColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 1)
		case clear:
			return UIColor.clearColor()
		}
	}
}

public enum Theme {
	/*
	A light Bar has a light (often gray background) with a dark title (or status) text color.
	A dark one has a transparent background (showing the dark theme below) and has light color text.
	A transparent one can be used as a prototype to add a custom background image to the NavigationBar.
	*/
	case dark, light, transparent
}

public enum Font {
	case button, titleText, bodyText, smalltext
	
	public func create() -> UIFont {
		switch self {
		case button:
			return UIFont.systemFontOfSize(17)
		case titleText:
			return UIFont.systemFontOfSize(20)
		case bodyText:
			return UIFont.systemFontOfSize(17)
		case smalltext:
			return UIFont.systemFontOfSize(12)
		}
	}
}

public func outlineViews(views: [UIView], outlineColor: UIColor) {
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