//
//  Scrolls.swift
//
//
//  Created by Timothy Bellay on 01/05/16.
//
//


import UIKit

public enum Direction {
	// NB: Scroll .Up means that the content moves up and that the user has swipped up.
	case Up, Down, Left, Right
}

public enum ScrollDirection {
	case Vertical, Horizontal, Both, None
}

public class ScrollView: NSObject, UIScrollViewDelegate {
	// scrollView properties
	let device: Device?
	public let view = UIScrollView(frame: .zero)
	var viewWidthAnchor: CGFloat?
	var viewHeightAnchor: CGFloat?
	var contentHeight: CGFloat?
	var contentWidth: CGFloat?
	
	// scroller properties
	var scrollDirection: ScrollDirection = .Both
	var showScrollers = true
	var showVerticalScroller = true
	var showHorizontalScroller = true
	var verticalScroller: UIView?
	var horizontalScroller: UIView?
	let scrollerOffset = 6 as CGFloat
	let scrollerThickness = 6 as CGFloat

	
	public init(device: Device, imageName: String?, scrollDirection: ScrollDirection, width: CGFloat?, height: CGFloat?, showScrollers: Bool) {
		self.device = device
		self.scrollDirection = scrollDirection
		self.showScrollers = showScrollers
		
		// Setup view anchors.
		if let widthAnchor = width {
			view.widthAnchor.constraintEqualToConstant(widthAnchor).active = true
			self.viewWidthAnchor = widthAnchor
		} else {
			view.widthAnchor.constraintEqualToConstant(device.frame().width).active = true
			self.viewWidthAnchor = device.frame().width
		}
		
		if let heightAnchor = height {
			view.heightAnchor.constraintEqualToConstant(heightAnchor).active = true
			self.viewHeightAnchor = heightAnchor
		} else {
			view.heightAnchor.constraintEqualToConstant(44).active = true
			self.viewHeightAnchor = 44
			print("WARNING: set scrollview height to minimum height: 44")
		}
		
		// Setup content and content size.
		if let name = imageName {
			if let image = UIImage(named: name) {
				let imageView = UIImageView(image: image)
				view.addSubview(imageView)
				view.contentSize = imageView.frame.size
				contentHeight = imageView.frame.size.height
				contentWidth = imageView.frame.size.width
			}
		} else {
			contentWidth = viewWidthAnchor
			contentHeight = viewHeightAnchor
		}
		view.contentSize = CGSizeMake(contentWidth!, contentHeight!) // TODO: if more views are added, contentSize needs to be updated to show all scrollable area and proper scroller bars. TB.
		
		super.init()
		view.delegate = self
		
		setupScrollers() // Warning: Only call setupScrollers() here, after content size and view anchors have been set.

		switch scrollDirection {
		case .None:
			view.scrollEnabled = false
			showHorizontalScroller = false
			showVerticalScroller = false
			self.showScrollers = false
			verticalScroller = nil
			horizontalScroller = nil
		case .Both:
			break
		case .Vertical:
			showHorizontalScroller = false
			horizontalScroller = nil
		case .Horizontal:
			showVerticalScroller = false
			verticalScroller = nil
		}
		view.translatesAutoresizingMaskIntoConstraints = false

		updateScrollers()
	}
	
	func setupScrollers() {
		
		let verticalHeight = viewHeightAnchor! / contentHeight! * viewHeightAnchor! - (2 * scrollerOffset)
		let horizontalHeight = viewWidthAnchor! / contentWidth! * viewWidthAnchor! - (2 * scrollerOffset)
		
		let verticalX = viewWidthAnchor! - scrollerOffset - scrollerThickness
		let verticalY = 0 + scrollerOffset

		let horizontalX = 0 + scrollerOffset
		let horizontalY = viewHeightAnchor! - scrollerOffset - scrollerThickness
		
		verticalScroller = UIView(frame: CGRectMake(verticalX, verticalY, scrollerThickness, verticalHeight))
		verticalScroller?.backgroundColor = .blackColor()
		verticalScroller?.alpha = 0.5
		verticalScroller?.layer.cornerRadius = 3
		
		horizontalScroller = UIView(frame: CGRectMake(horizontalX, horizontalY, horizontalHeight, scrollerThickness))
		horizontalScroller?.backgroundColor = .blackColor()
		horizontalScroller?.alpha = 0.5
		horizontalScroller?.layer.cornerRadius = 3

		view.addSubview(verticalScroller!)
		view.addSubview(horizontalScroller!)
		
		print("setup Scrollers")
	}
	
	func updateScrollers() {
		if !showScrollers {
			return
		}
		print("updating Scrollers NOW")
		let contentFrame = view.subviews[0].frame

		if let horizontal = horizontalScroller {
			print("OLD horizontal frame: \(horizontal.frame)")
			var scrollerFrame = horizontal.frame
			let newX = (0 - contentFrame.origin.x) * (viewWidthAnchor! / contentWidth!) + scrollerOffset
			scrollerFrame.origin.x = newX
			horizontal.frame = scrollerFrame
			print("NEW horizontal frame: \(horizontal.frame)")
		}
		
		if let vertical = verticalScroller {
			print("OLD vertical frame: \(vertical.frame)")
			var scrollerFrame = vertical.frame
			let newY = (0 - contentFrame.origin.y) * (viewHeightAnchor! / contentHeight!) + scrollerOffset
			scrollerFrame.origin.y = newY
			vertical.frame = scrollerFrame
			print("NEW vertical frame: \(vertical.frame)")
		}
		
	}
	
	public func scrollViewDidScroll(scrollView: UIScrollView) {
		print("Scrolling delegate called!")
	}
	
	public func center() {
		let half = 1/2 as CGFloat
		view.subviews[0].center.x = device!.frame().width * half
		view.subviews[0].center.y = device!.frame().height * half
		self.updateScrollers()
	}
	
	public func scroll(direction: Direction, amount: CGFloat) {
	// NB: This method removes the scrollers first since all subviews to the scrollView "view" become reposistioned below.
		horizontalScroller?.removeFromSuperview()
		verticalScroller?.removeFromSuperview()
		let subviews = view.subviews
		for subview in subviews {
			var center = subview.center
			print("OLD center: \(center)")
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
			print("NEW center: \(center)")
		}
		setupScrollers()
		updateScrollers()
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

