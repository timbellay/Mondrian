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
	public var screenType: ScreenType = .splash
	public var device: Device = .iPhone6
	public var theme: Theme = .dark
	public var orientation: UIDeviceOrientation = .Portrait
	public var view = UIView()
	public var mainSV: UIStackView?
	public var views = [UIView]()
	
	public init(device: Device, type: ScreenType, theme: Theme) {
		self.device = device
		view.frame = device.frame()
		self.screenType = type
		self.theme = theme
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

	public init(device: Device, type: ScreenType, imageName: String) {
		self.init(device: device, type: type, theme: .dark)
		splash(imageName)
		let statusBar = StatusBar(frame: view.frame, theme: .dark)
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

		let statusBar = StatusBar(frame: .zero, theme: theme)
		views.append(statusBar.view)
		let navBar = NavigationBar(frame: .zero, theme: theme, title: "Title")
		views.append(navBar.view)
		let searchBar = SearchBar(frame: .zero, theme: theme)
		views.append(searchBar.view)
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		if theme == .light {
			tableView.backgroundColor = Color.grayBackground.create()
		} else {
			tableView.backgroundColor = .clearColor()
		}
		views.append(tableView)
		let toolBar = ToolBar(frame: .zero, theme: theme)
		views.append(toolBar.view)
		let tabBar = TabBar(frame: .zero, theme: theme)
		views.append(tabBar.view)
		
		let viewDict = [ "statusBar" : statusBar.view, "navBar" : navBar.view, "searchBar" : searchBar.view, "toolBar" : toolBar.view, "tableView" : tableView, "tabBar" : tabBar.view]
		
		let keys = Array(viewDict.keys)

		views.forEach({
			mainSV?.addArrangedSubview($0)
		})
		
		let horizontalVL = keys.map{"|[\($0)]|"}
		setConstraints(horizontalVL, views: viewDict)
		var verticalVL = keys.map{"V:[\($0)(44)]"}
		verticalVL[0] = "V:[statusBar(20)]"
		verticalVL.removeAtIndex(4) // TODO remove this and add vertical height for each toolbar based on an enum. TB. case: status = 20, case: tab = 49, case tool = 44. TB.
		print("views: \(verticalVL)")
		setConstraints(verticalVL, views: viewDict)
	}
	
	func setConstraints(visualLanguage: Array<String>, views: Dictionary<String, UIView>) {
		var layoutConstraints = [NSLayoutConstraint]()
		visualLanguage.forEach({
			layoutConstraints += NSLayoutConstraint.constraintsWithVisualFormat($0, options: [], metrics: nil, views: views)
		})
		NSLayoutConstraint.activateConstraints(layoutConstraints)
	}
}