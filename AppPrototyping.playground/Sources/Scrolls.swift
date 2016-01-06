//
//  Scrolls.swift
//
//
//  Created by Timothy Bellay on 01/05/16.
//
//


import UIKit

public enum Direction {
	case Up, Down, Left, Right
}

public enum ScrollDirection {
	case Vertical, Horizontal, Both, None
}

public class ScrollView: NSObject, UIScrollViewDelegate {
	public let view = UIScrollView(frame: .zero)
	let device: Device?
	var scrollDirection: ScrollDirection = .Both
	
	public init(device: Device, imageName: String?, scrollDirection: ScrollDirection, width: CGFloat?, height: CGFloat?) {
		self.device = device
		self.scrollDirection = scrollDirection
		if let name = imageName {
			if let image = UIImage(named: name) {
				let imageView = UIImageView(image: image)
				view.addSubview(imageView)
				view.contentSize = imageView.frame.size
			}
		}
		
		switch scrollDirection {
		case .None:
			view.scrollEnabled = false
		case .Both:
			break
		case .Vertical:
			break
		case .Horizontal:
			break
		}
		
		if let widthAnchor = width {
			view.widthAnchor.constraintEqualToConstant(widthAnchor).active = true
		} else {
			view.widthAnchor.constraintEqualToConstant(device.frame().width).active = true
		}
		
		if let heightAnchor = height {
			view.heightAnchor.constraintEqualToConstant(heightAnchor).active = true
		} else {
			view.heightAnchor.constraintEqualToConstant(44).active = true
			//			print("set scrollview height to 300")
		}
		
		//		super.init()
		//		view.delegate = self
		view.translatesAutoresizingMaskIntoConstraints = false
	}
	
	public func scrollViewDidScroll(scrollView: UIScrollView) {
		print("Scrolling delegate called!")
	}
	
	public func center() {
		let half = 1/2 as CGFloat
		view.subviews[0].center.x = device!.frame().width * half
		view.subviews[0].center.y = device!.frame().height * half
	}
	
	public func scroll(direction: Direction, amount: CGFloat) {
		let subviews = view.subviews
		for subview in subviews {
			var center = subview.center
			print("old center: \(center)")
			switch direction {
			case .Up:
				center.y -= amount
			case .Down:
				center.y += amount
			case .Left:
				center.x -= amount
			case .Right:
				center.x += amount
			}
			subview.center = center
			print("new center: \(center)")
		}
	}
}


