//: [Previous](@previous)

import UIKit
import XCPlayground


class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var tableView: UITableView!
	let items = ["Hello 1", "Hello 2", "Hello 3"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.frame = Device.iPhone5.frame()
		self.tableView = UITableView(frame: self.view.frame)
		self.tableView!.dataSource = self
		self.tableView!.translatesAutoresizingMaskIntoConstraints = false
		self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
		self.view.addSubview(self.tableView)
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
		return self.items.count;
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
		cell.textLabel?.text = "\(self.items[indexPath.row])"
		cell.backgroundColor = .purpleColor()
		return cell
	}
}

class ScrollController: UIScrollViewDelegate {
	var scrollView: UIScrollView?
	init() {
		
	}
	override func scrollViewDidScroll(scrollView: UIScrollView) {
		
	}
}



let device = Device.iPhone5
let frame = device.frame()
let view = UIView(frame: frame)
view.backgroundColor = .purpleColor()
let scrollView = UIScrollView(frame: .zero)
scrollView.contentSize = frame.size
scrollView.pagingEnabled = true
scrollView.backgroundColor = .whiteColor()

let subview = UIView(frame: CGRectMake(0,0,44,44))
subview.backgroundColor = .orangeColor()
//scrollView.addSubview(subview)


let sv = makeVerticalSV(view)
let statusbar = StatusBar(frame: device.frame(), theme: .dark)
sv.addArrangedSubview(statusbar.view)
sv.addArrangedSubview(scrollView)
sv.addArrangedSubview(subview)
view.frame.size
sv.frame.size
scrollView.frame.size
subview.superview

XCPlaygroundPage.currentPage.liveView = view
scrollView.contentSize

outlineViews([view], outlineColor: .whiteColor())
//: [Next](@next)
