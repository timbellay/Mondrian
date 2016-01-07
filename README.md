# Mondrian - Swift App prototyping in Xcode Playgrounds!

- Quick and flexibly prototype iOS screens using Swift 2.x and Xcode Playgrounds with minimal code.
- Codebase is subject to major architectural changes as Swift is still pretty new.
- PRs and suggestions are welcome!

# Usage:

```
import UIKit
import XCPlayground

let device = Device.iPhone6
var statusBar = StatusBar(frame: device.frame(), theme: .light)
XCPlayground.XCPlaygroundPage.currentPage.liveView = statusBar.view
```
#Soon come:

##[Bars]
- [x] StatusBar
	- [x] Cellular signal strength meter
	- [x] Carrier labels
		- [ ] more carrier labels, e.g. Sprint, AT&T, etc.
	- [ ] WiFi signal strength meter
	- [x] Time
	- [ ] Phone is using location services and alarm icon, etc.
- [x] NavigationBar
	- [ ] Ability to add SearchBar to NavigationBar
- [x] ToolBar
	- [ ] default toolbar that take three buttons
	- [ ] ToolBar divider/separator (left, up, right, down)
- [x] TabBar
- [x] SearchBar
- [ ] use UIBarSyle enum for bars?

##[Screens you should be able to make in v1.0]
- [ ] Form, e.g. login, join 
- [ ] Login, see Form below
- [ ] Post, e.g. status update, message, or photo
- [x] ScrollView 
	- [x] scroll bars
	- [ ] fadeView to indicate more content in a scrollable dirextion such as a textView in a scrollView
- [ ] Feed, i.e. List or UITableViewController
- [ ] Settings, type of Feed above
- [ ] Collection, i.e collectionView
- [ ] Detail, i.e a single cell in Feed
- [ ] Page, i.e. pageViewController, e.g. on-boarding

##[Controls you should be able to add anywhere in v1.0]
- [ ] Button, label (left, up, right, down)
- [ ] Sliders
- [ ] Steppers
- [ ] Switches
- [ ] Text Fields
	- [ ] ability to show/hide keyboard
- [ ] Segmented Controls
- [ ] Date Pickers
- [ ] Page Controls
- [ ] ActionSheet
- [ ] Popover, i.e “new updates” for Feed
- [ ] AlertView, including System Notifications used in app permission granting. 
- [ ] Activity indicators 
	- [ ] with animations

##[UIView extension]
- [ ] Ability to add other views to the left, top, right, or bottom of view.

##[Resources]
- [ ] Open source icons and other default icons to speed up prototyping

##[Cells]
- [ ] TableViewCell templates (4-5 options to start with)
    - [ ] style: Facebook 
- [ ] CollectionViewCell templates

##[Data & Backend]
- [ ] Data manager singleton with:
    - [ ] DateFormatter
    - [ ] Get pseudo data to fill tables and other Screens
