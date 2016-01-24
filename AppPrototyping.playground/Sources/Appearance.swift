//
//  Appearance.swift
//
//
//  Created by Timothy Bellay on 12/6/15.
//
//

import UIKit

public enum Color {
	case DarkText, LightText, BlueLink, GrayBackground, GrayLine, Pink, Clear
	
	public func create() -> UIColor {
		switch self {
		case DarkText:
			return UIColor.darkTextColor()
		case LightText:
			return UIColor.lightTextColor()
		case BlueLink:
			return UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1)
		case GrayBackground:
			return UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
		case GrayLine:
			return UIColor(red: 206/255, green: 206/255, blue: 210/255, alpha: 1)
		case Pink:
			return UIColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 1)
		case Clear:
			return UIColor.clearColor()
		}
	}
}

public enum Theme {
	case Dark, Light, DarkTransparent, LightTransparent, Custom
}

public struct Appearance {
	public var theme: Theme
	var customTextColor: UIColor?
	var customLabelColor: UIColor?
	
	public init(theme: Theme, textColor: UIColor?, labelColor: UIColor?) {
		self.theme = theme
		customTextColor = textColor
		customLabelColor = labelColor
	}
	
	public func textColor() -> UIColor {
		var color: UIColor = .blackColor()
		switch theme {
		case .Dark, .DarkTransparent:
			color = .whiteColor()
		case .Light, .LightTransparent:
			color = .blackColor()
		case .Custom:
			if let customColor = customTextColor {
				color = customColor
			}
		}
		return color
	}
	
	public func labelColor() -> UIColor {
		var color: UIColor = .blackColor()
		switch theme {
		case .Dark:
			color = .blackColor()
		case .Light:
			color = .whiteColor()
		case .DarkTransparent, .LightTransparent:
			color = .clearColor()
		case .Custom:
			if let customColor = customLabelColor {
				color = customColor
			}
		}
		return color
	}
	
	public func setStrokeAndFill() {
		switch theme {
		case .Light, .LightTransparent:
			UIColor.blackColor().setStroke()
			UIColor.blackColor().setFill()
		case .Dark, .DarkTransparent:
			UIColor.whiteColor().setStroke()
			UIColor.whiteColor().setFill()
		case .Custom:
			customTextColor?.setStroke()
			customTextColor?.setFill()
		}
	}
	
}



public enum Font {
	case Button, TitleText, BodyText, SmallText, TabBarText
	
	public func create() -> UIFont {
		switch self {
		case Button:
			return UIFont.systemFontOfSize(17)
		case TitleText:
			return UIFont.systemFontOfSize(20)
		case BodyText:
			return UIFont.systemFontOfSize(17)
		case SmallText:
			return UIFont.systemFontOfSize(12)
		case TabBarText:
			return UIFont.systemFontOfSize(10)
		}
	}
}