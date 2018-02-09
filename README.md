# RoundCoachMark
=============

This is an useful tiny library to help you quickly add the ability of some coach scenarios into your apps.

![Watch the demo](https://i.imgur.com/VuMzli4.mp4)

## Quick Start

### Cocoapods
You can use this layout in your project by adding to your podfile:
<pre>pod 'RoundCoachMark'</pre>

## Usage

**Create coachmark object**
```swift
let coachMarker = CoachMarker(in:view, infoPadding:20)
```

**Add new coachmark to some view**

```swift
CoachMarker.registerMark(title:"Title coach", info:"Some training cool information.", control:buttonNeedsToExplain)
```

## Requirements
