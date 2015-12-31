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

let device = Device.iPhone5
let frame = device.frame()
let statusbar = StatusBar(frame: device.frame(), theme: .dark)

var listController: ListController = ListController()
listController.viewDidLoad()
listController.tableView?.separatorStyle = .None

var view = UIView(frame: device.frame())
XCPlaygroundPage.currentPage.liveView = view
var sv = makeVerticalSV(view)

sv.addArrangedSubview(statusbar.view)
sv.addArrangedSubview(listController.view)
sv.frame = device.frame()

outlineViews([view], outlineColor: .whiteColor())

//: [Next](@next)
