
//
//  Screens.swift
//
//
//  Created by Timothy Bellay on 12/6/15.
//
//

import Foundation
import UIKit

public enum ScreenType {
	case splash
	case login
	case post // i.e. status update, message, photo
	case list
	case collection
	case detail
	case settings
}

// Screen resolutions in pts.
public enum Device {
	case iPhone4s, iPhone5, iPhone5s, iPhone6, iPhone6Zoom, iPhone6Plus, iPhone6PlusZoom, iPhone6S, iPhone6SZoom, iPhone6SPlus, iPhone6SPlusZoom, iPad, iPadMini, iPadAir, iPadPro, appleWatch38mm, appleWatch42mm, appleTV1080p
	
	public func size() -> CGSize {
		var size = CGSizeZero
		switch self {
		case iPhone4s:
			size.width = 320; size.height = 480
		case .iPhone5:
			size.width = 320; size.height = 568
		case iPhone5s:
			size.width = 320; size.height = 568
		case iPhone6:
			size.width = 375; size.height = 667
		case iPhone6Zoom:
			size.width = 320; size.height = 568
		case iPhone6Plus:
			size.width = 414; size.height = 736
		case iPhone6PlusZoom:
			size.width = 375; size.height = 667
		case iPhone6S:
			size.width = 320; size.height = 568
		case iPhone6SZoom:
			size.width = 375; size.height = 667
		case iPhone6SPlus:
			size.width = 414; size.height = 736
		case iPhone6SPlusZoom:
			size.width = 375; size.height = 667
		case iPad:
			size.width = 768; size.height = 1024
		case iPadMini:
			size.width = 768; size.height = 1024
		case iPadAir:
			size.width = 768; size.height = 1024
		case iPadPro:
			size.width = 1024; size.height = 1366
		case appleWatch38mm:
			size.width = 272; size.height = 340 // TODO: In px, convert to pt. TB.
		case appleWatch42mm:
			size.width = 312; size.height = 390 // TODO: In px, convert to pt. TB.
		case appleTV1080p:
			size.width = 1920; size.height = 1080 // TODO: In px, convert to pt. TB.
		}
		return size
	}
	
	public func frame() -> CGRect {
		let size = Device.size(self)
		return CGRectMake(0, 0, size().width, size().height)
	}
}

public struct Screen {
	public var device: Device = .iPhone6
	public var screenType: ScreenType = .splash
	public var appearance: Appearance?
	public var view = UIView()
	public var mainSV: UIStackView?
	public var views = [UIView]()
	var statusBar: StatusBar? = nil
	var navBar: NavigationBar? = nil
	var customViews: [ScrollView]? = nil
	var tableViews: [TableView]? = nil
	var collectionViews: [ScrollView]? = nil // TODO: add CollectionView Class.
	var toolbars: [ToolBar]? = nil
	var tabBar: TabBar? = nil
//	var popOvers: [PopOver]? = nil // TODO: add PopOver Class.
//	var systemNotifications: [SystemNotificaiton]? = nil // TODO: add SystemNotificaiton Class.
//	var alertViews: [AlertView]? = nil // TODO: add AlertView Class.
//	var activityIndicators: [ActivityIndicator]? = nill // TODO: add ActivityIndicator Class.
	
	public init(device: Device, type: ScreenType, appearance: Appearance) {
		self.device = device
		view.frame = device.frame()
		self.screenType = type
		self.appearance = appearance
		mainSV = makeVerticalSV(view)
		mainSV!.distribution = .Fill

		switch self.screenType {
		case .splash:
			break
		case .login:
			break
		case .post: // i.e. status update, message, photo
			break
		case .list:
			self.list()
		case .collection:
			break
		case .detail:
			break
		case .settings:
			break
		}
	}

	public init(device: Device, type: ScreenType, imageName: String, appearance: Appearance) {
		self.init(device: device, type: type, appearance: appearance)
		splash(imageName)
		let statusBar = StatusBar(frame: view.frame, appearance: appearance)
		view.addSubview(statusBar.view)
	}
	
	public func splash(_name: String) {
		if let splashImage = UIImage(named: _name) {
			let splashImageView = UIImageView(image: splashImage)
			if let stackView = mainSV {
				stackView.addArrangedSubview(splashImageView)
			}
		}
	}
	
	mutating func list() {
		
		let statusBar = StatusBar(frame: .zero, appearance: appearance!)
		let navBar = NavigationBar(frame: .zero, appearance: appearance!, title: "Title")
		let searchBar = SearchBar(frame: .zero, appearance: appearance!)
		
		let cell1 = Cell(device: device, cellType: .Simple, appearance: appearance!)
		let cell2 = Cell(device: device, cellType: .Simple, appearance: appearance!)
		let tableView = TableView(device: device, width: nil, height: device.frame().height - 64, cells: [cell1, cell2])
		tableView.view.backgroundColor = appearance?.labelColor()
	
		views.append(statusBar.view)
		views.append(navBar.containerView!.view!)
		views.append(searchBar.view)
		views.append(tableView.view)


		let toolBar = ToolBar(frame: .zero, appearance: appearance!)
		let tabBar = TabBar(frame: .zero, appearance: appearance!)

		views.append(toolBar.view)
		views.append(tabBar.view)
		
		let viewDict = [ "statusBar" : statusBar.view, "navBar" : navBar.containerView!.view!, "searchBar" : searchBar.view, "toolBar" : toolBar.view, "tableView" : tableView.view, "tabBar" : tabBar.view]
		
		let keys = Array(viewDict.keys)

		views.forEach({
			mainSV?.addArrangedSubview($0)
		})
		
		let horizontalVL = keys.map{"|[\($0)]|"}
		setConstraints(horizontalVL, views: viewDict)
		var verticalVL = keys.map{"V:[\($0)(44)]"}
		verticalVL[0] = "V:[statusBar(20)]" // StatusBar height to 20 instead of 44.
		verticalVL.removeAtIndex(4) // Remove tableView constraint. TODO remove this and add vertical height for each toolbar based on an enum. TB. case: status = 20, case: tab = 49, case tool = 44. TB.
		print("verticalVL: \(verticalVL)")
		setConstraints(verticalVL, views: viewDict)
	}
}