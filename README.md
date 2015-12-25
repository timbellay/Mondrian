# app-prototyping-swift-playground

- Prototype iOS screens in Swift 2.x playgrounds using minimal code.
- Codebase is in a very preliminary state and subject to major architectural changes. 
- PRs and suggestions are welcome!

# usage:

`import UIKit
import XCPlayground

let device = Device.iPhone6
var statusBar = StatusBar(frame: device.frame(), theme: .light)
XCPlayground.XCPlaygroundPage.currentPage.liveView = statusBar.view`

#Soon come:

##[Screens]
- login
- settings
- scrollView, with fade to indicate more content, scroll to line xx
- show/hide keyboard
- forms, e.g. login, join 
- posts, e.g. status update, message, or photo
- list or feed screen, e.g. tableViewController
- collection sceen, e.g. collectionView
- detail, single cell list, tableViewController
- settings, tableViewController
- page, pageViewController, e.g. on-boarding

##[UIView extension]
- ability to add other views to the left, top, right, or bottom of view.

##[Controls]
- add button maker (UIStackView), label (left, up, right, down)
- actionSheets
- popovers, “new updates” and others
- alertView including System Notifications used in app permission granting. 
- activity indicators with animations

##[Resources]
- add open source icons as placeholders for default icons

##[Bars]
- add search to navigation bar
- default toolbar that take three buttons
- toolbar divider/ separator (left, up, right, down)
- use UIBarSyle enum for bars?

##[Cells]
- tableviewcell simple & custom
    - style: Facebook & other app styles
- collection view cells, simple & custom

##[Data]
- data manager singleton with:
    - dateformatter, other expensive formatters go here
    - gets/creates pseudo data to fill tables, etc.
