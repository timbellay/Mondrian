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


let device = Device.iPhone6
let frame = device.frame()
let view = UIView(frame: frame)
let sv = makeVerticalSV(view)
let statusBar = StatusBar(frame: frame, theme: .light)
sv.addArrangedSubview(statusBar.view)
horizontalStrechToParentView(statusBar.view)

let svc = ScrollView(device: device, imageName: "splash", scrollDirection: .Both, width: nil, height: 500)
sv.addArrangedSubview(svc.view)
svc.center()
//svc.scroll(.Left, amount: 100)

let tabbar = TabBar(frame: frame, theme: .light)
sv.addArrangedSubview(tabbar.view)

XCPlaygroundPage.currentPage.liveView = view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
view.frame = device.frame()

//outlineViews([view], outlineColor: .whiteColor())
//: [Next](@next)
