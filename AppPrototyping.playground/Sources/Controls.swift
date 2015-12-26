//
//  Controls.swift
//
//
//  Created by Timothy Bellay on 12/6/15.
//
//

import UIKit

// Buttons can have outline (typically if transparent) or not.

public enum ButtonLabelType {
	case Left, Right, Up, Down, None
}

public struct Button {
	var view = UIView()
	var mainSV: UIStackView?
	var type: ButtonLabelType = .None
	var image: UIImage?
	var text: String?
	var views = [UIView]()
	
	public init(theme: Theme, imageName: String, text: String, type: ButtonLabelType) {
		self.type = type
		let font = Font.tabBarText.create()
		var label = UILabel()
		if theme == .light {
			let gray = Color.grayBackground.create()
			view.backgroundColor = gray
			label = UILabel(text: text, font: font, textColor: Color.blueLink.create(), labelColor: gray)
		} else {
			view.backgroundColor = .clearColor()
			label = UILabel(text: text, font: font, textColor: .whiteColor(), labelColor: .clearColor())
		}
		
		if let image = UIImage(named: imageName) {
			let imageView = UIImageView(image: image)
			imageView.contentMode = .ScaleAspectFit
			switch type {
			case .Left:
				mainSV = makeHorizontalSV(view)
				views.append(label)
				views.append(imageView)
			case .Right:
				mainSV = makeHorizontalSV(view)
				views.append(imageView)
				views.append(label)
			case .Up:
				mainSV = makeVerticalSV(view)
				views.append(label)
				views.append(imageView)
			case .Down:
				mainSV = makeVerticalSV(view)
				views.append(imageView)
				views.append(label)
			case .None:
				mainSV = makeVerticalSV(view)
				views.append(label)
			}
		}
		views.forEach({mainSV?.addArrangedSubview($0)})
//		view.layer.cornerRadius = 5
	}
}