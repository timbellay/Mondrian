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
	var showHorizontalScroller = true
	var showVerticalScroller = true
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
			showHorizontalScroller = false
			showVerticalScroller = false
		case .Both:
			break
		case .Vertical:
			showHorizontalScroller = false
		case .Horizontal:
			showVerticalScroller = false
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
			print("WARNING: set scrollview height to minimum height: 44")
		}
		view.translatesAutoresizingMaskIntoConstraints = false

		super.init()
		view.delegate = self
		
		self.drawScrollIndicators()
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
	
	func drawScrollIndicators() {
		// TODO: Implement me!
		
		// Research iOS behavior first
		// Make two rounded rects based upon scroller bool properties
		// Draw lengths to be size of view
		// Draw position to be postion in content view
	}
}

public class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var tableView: UITableView!
	let items = ["Hello 1", "Hello 2", "Hello 3"]
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		view.frame = Device.iPhone5.frame()
		tableView = UITableView(frame: self.view.frame)
		tableView.dataSource = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.view.addSubview(self.tableView)
	}
	
	public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
		return self.items.count;
	}
	
	public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
		cell.textLabel?.text = "\(self.items[indexPath.row])"
		cell.backgroundColor = .purpleColor()
		return cell
	}
}

