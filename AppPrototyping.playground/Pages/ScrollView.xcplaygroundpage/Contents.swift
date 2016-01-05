//: [Previous](@previous)

import UIKit
import XCPlayground


class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	var tableView: UITableView!
	let items = ["Hello 1", "Hello 2", "Hello 3"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.frame = Device.iPhone5.frame()
		tableView = UITableView(frame: self.view.frame)
		tableView.dataSource = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
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

class ScrollController: NSObject, UIScrollViewDelegate {
//	var scrollView: UIScrollView!
	var scrollView = UIView(frame: .zero)
	init(frame: CGRect) {
		
//		scrollView = UIScrollView(frame: frame)
//		scrollView.contentSize = frame.size
//		super.init()
//		scrollView.delegate = self
		
		scrollView.frame = frame
		scrollView.backgroundColor = .purpleColor()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		
	}
	func scrollViewDidScroll(scrollView: UIScrollView) {
		print("Scrolling")
	}
}

let device = Device.iPhone6
let frame = device.frame()
let view = UIView(frame: frame)
let sv = makeVerticalSV(view)
let statusBar = StatusBar(frame: frame, theme: .dark)
sv.addArrangedSubview(statusBar.view)
horizontalStrechToParentView(statusBar.view)

let navbar = NavigationBar(frame: frame, theme: .dark, title: "Hello")
sv.addArrangedSubview(navbar.view)
//horizontalStrechToParentView(navbar.view)
navbar.view


let svc = ScrollController(frame: CGRectMake(0, 0, frame.width, 200))
sv.addArrangedSubview(svc.scrollView)
svc.scrollView
horizontalStrechToParentView(svc.scrollView)


XCPlaygroundPage.currentPage.liveView = view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
view.frame = frame

//outlineViews([view], outlineColor: .whiteColor())
//: [Next](@next)
