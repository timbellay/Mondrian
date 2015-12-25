//
//  Controls.swift
//
//
//  Created by Timothy Bellay on 12/6/15.
//
//

import UIKit

public enum Button {
	case Default, transparent, transparentWithOutline
	
	public func create() -> UIButton {
		var button = UIButton(type: .System)
		switch self {
		case Default:
			button.backgroundColor = Color.grayBackground.create()
			button.setTitle("Button", forState: .Normal)
			button.setTitleColor(Color.blueLink.create(), forState: .Normal)
			button.titleLabel?.font = Font.button.create()
			button.layer.cornerRadius = 5
		case transparent:
			button.backgroundColor = Color.clear.create()
			button.setTitle("Button", forState: .Normal)
			button.setTitleColor(Color.blueLink.create(), forState: .Normal)
			button.titleLabel?.font = Font.button.create()
			button.layer.cornerRadius = 5
		case .transparentWithOutline:
			button = Button.transparent.create()
			button.layer.borderColor = button.titleLabel?.textColor.CGColor
			button.layer.borderWidth = 1
		}
		return button
	}
}