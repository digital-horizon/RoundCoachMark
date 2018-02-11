# RoundCoachMark

[![Swift][swift-badge]][swift-url]
[![Platform][platform-badge]][platform-url]

**RoundCoachMark** is a small Swift library for showing animated focused on GUI element round-shaped overlays - coach marks - with text for onboarding or run-time help purposes.

**RoundCoachMark** supports customization. You can set colors, fonts and adjust dynamics.

**RoundCoachMark's** main feature is the mechanism of pre-registration of a coach marks - you register a mark when it is convenient to do (on appearence or configuration) and forget about it. Next time the CoachMarker starts it will find the mark and show it as appropriate. You can show marks for basic GUI elements like buttons, input fields, labels and icons independently of whether they are static or appears, say, in table view cell. 

## Usage

There are two basic scenarios for coach marks. 
The first one is illustrated by `SimpleCoachMarkerDemoVC` in demo project. In this scenario of GUI elemnts - controls - you want to show up are in the the same view controller, thus you can add them to the CoachMarker directly

### Simple scenario

A view controller class declarations:

```swift

@IBOutlet weak var gearButton: UIButton!
@IBOutlet weak var exitButton: UIButton!

private var coachMarker:CoachMarker?

```

In some setup method:

```swift
coachMarker = CoachMarker(in:self.view, infoPadding:20)

coachMarker!.addMark(title:"Gear up!", info:"Tap the icon to open Settings screen.", 
                     control:gearButton)
coachMarker!.addMark(title:"Get out of here!", info:"Tap this to exit", 
                     control:exitButton)

```
There are several methods to add (or register) a mark. Please, see the demo project to find all.

Finally in `viewDidAppear` to start right away or in help-button handler

```swift
coachMarker?.tapPlay(autoStart:true, completion:{print("tapPlay finished")})

// or

coachMarker?.autoPlay(delay:0.5, interval:1, completion:{print("autoPlay finished")})

```

Both play-methods shows all added marks one after another then destroy the marker, or alternatively you can avoid the marker destrruction with flag and reuse it later. 
        
### Realistic scenario

The second scenario is more realistic. It is illustrated by `ComplexCoachMarkerDemoVC`. Imagine your screen consists of several view controllers and hierarchy of views: root container controller (custom or system provided like navigation controller), embedded bars/menu controllers, a child content controller with table view and cells containing controls you whant to show up with the CoachMarker.
Apparently, you will want to create the CoarchMarker on root container controller level, but how to reach out the contlols from that level? Here is how.
Instead of adding a mark to the marker directly you pre-register it in some method which is guarantied to start before the marker created:

```swift

CoachMarker.registerMark(title:"Show modal view controller", 
                         info:"A modal view controller brings his owm coach marks, so other marks are to be disabled. It's done by 'unregistering' active marks in viewWillDisappear of overlapped controllers.", 
                         control:showmodalButton,
                         markTag:"scenario-2")

```
As you see you can use `markTag:` parameter to tag a mark and then it will only be shown by the marker tagged with the same tag. Thus you can have as many markers as you need. Alternatively, you can unregister marks. 
Now you create the marker and start it as in the simple scenario.

```swift

coachMarker = CoachMarker(in:marksContainer, infoPadding:20, tag:"scenario-2")

...

coachMarker?.tapPlay(autoStart:true, destroyWhenFinished:false)

```

The play methods are not the only way to control showing of marks. You can construct your own logic of showith marks and implement it using the CoachMarker interface methods:

```swift

public func presentMark(_ index:Int, completion:@escaping ()->Void)
public func dismissMark(completion:@escaping ()->Void)
public func presentNextMark(completion:@escaping ()->Void)

```
