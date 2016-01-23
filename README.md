# Mondrian - App prototyping in Xcode Playgrounds!

- Quick and flexibly prototype iOS screens using Swift 2.x and Xcode Playgrounds with minimal code.
- Note this project is on hold for a bit.

# Update 01-22-16:
I'm cooling off dev for Mondrian for at least a month (Feb.) to work on something else that's come up, but here's an update on some major things I've learned to remind me when I get back to this project.

When I set out to make this set of prototyping tools, I made at least three naive miscalculations. 

# 1) UIStackViews were supremely powerful. Nope.
I thought they could solve the general problem of sticking views anywhere, but they do not. StackViews are more suited for repetitive components such as a group of buttons, equally sized and perhaps horizontally laid out. I'll definitely keep using them in the future instead of repeatedly adding a set of subviews through constraints. In Mondrian, vertical UIStackViews were used to position containers such as the statusBar, navigationBar, content views, toolbars and tabBars into a Screen. One good discovery was UILayoutGuides. They work well for spacing views apart in precise ways and eliminate using spacer views.

# 2) Playgrounds have the same functionality as the iOS simulators they borrow from. Nope. 
I knew Apple had removed some functionality including interactivity from playgrounds in the last Xcode update, but that wouldn't kill the main function of this tool, i.e. prototyping iOS screens. I decided to press forward and I first discovered that could not use UIKit properly because delegates involving interactivity (such as scrollViewDidScroll) were not getting called in Playgrounds, because there was no interaction period. Bummer. So I just went ahead an laid out views in containers anyways, since we just needed mocks. However without interactivity, it becomes harder to answer the question of "Why not just prototype in Storyboards?" Plus with storyboards, you can use the resulting nibs and then go build an app. 

#3) I could avoid MVC. Nah.
I guess I thought "Hey this is a playground, MVC probably doesn't play well with others out here. He belongs inside, in timeout." EPIC_ERROR. After now knowing pretty much all of the UI components that I'd liked to be able to place with this tool, I have a pretty good idea of the way forward with MVC and potentially get us set up with maybe with some FRP. We'll have a Model object representing an abstract screen and it will be sent to a LayoutController that builds the Screen as views, mostly in preset ways. If Apple adds back interactivity, we'll be able to have "real" ViewControllers in a navigation stack. Thus the model is pretty simple, and composed of an App class that has a Device class, an optional array of Screens, a optional DataManager class and an optional Appearance class. The Screen class is just a long list of optional arrays of UI components e.g. [CustomView]?, [TableView]?, [CollectionView]?, ... [Alert]?, [PopOver]?, [ActivityIndicator]?. A Layout class would then take care of either adding views to UIStackView or for simple prebuilt controls, use UILayoutguides, e.g. a simple tableViewCell. I'll post a pic of the Model. Importantly the DataManager has dictionary with classes for keys that tell us what settable properties of the UIComponents we will support changing. And each UI component has a data dictionary with the settable data we want to populate the model. 

Any suggestions or comments are welcome.


# Usage:

```
import UIKit
import XCPlayground

let device = Device.iPhone6
let screen = Screen(device: device, type: .list, theme: .dark)
XCPlayground.XCPlaygroundPage.currentPage.liveView = screen.view
```
![ScreenShot](https://raw.github.com/timbellay/Mondrian/master/screens/list.png)

#Soon come:

##[Screens]
- [ ] Form, e.g. login, join 
- [ ] Login, see Form below
- [ ] Post, e.g. status update, message, or photo
- [x] ScrollView 
	- [x] scroll bars
	- [ ] fadeView to indicate more content in a scrollable direction such as a textView in a scrollView
- [X] Feed, i.e. List or UITableViewController
	- [x] simple tableViewCell
	- [ ] section cells or headers
	- [ ] other types, plus tutorial on custom tableViewCell using ContainerView class.
- [ ] Settings, type of Feed above
- [ ] Collection, i.e collectionView
- [ ] Detail, i.e a single cell in Feed
- [ ] Page, i.e. pageViewController, e.g. on-boarding

##[Bars you should be able to add to any screen]
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
	- [ ] ToolBar separator (left, up, right, down)
- [x] TabBar
- [x] SearchBar
- [ ] use UIBarSyle enum for bars? also a gentle reminder to use UIKit enums when possible

##[Controls you should be able to add anywhere]
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

##[Resources]
- [ ] Open source icons and other default icons to speed up prototyping

##[Data & Backend]
- [ ] Data manager singleton with:
    - [ ] DateFormatter
    - [ ] Get pseudo data to fill tables and other Screens
