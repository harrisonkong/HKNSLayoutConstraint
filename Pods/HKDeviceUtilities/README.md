# HKDeviceUtilities
#### HK Utilities for UIDevice

## SUMMARY

This module provides methods that return information about UIDevice. This is a required module for many other Swift HK modules.

## PUBLIC UTILITY METHODS AVAILABLE

Note: It is advised that you call these methods after a slight delay when responding to the UIDevice.orientationDidChangeNotification notification so that the width and height have a chance to update.

Example:

```
   DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {

       let screenWidth = hkScreenWidth()
       let screenHeight = hkScreenHeight()
       // other code
   }
```

### public func hkIsLandscape() -> Bool ###

Uses `UIDevice.current.orientation`:
For `.portrait`, `.portraitUpsideDown`: return false
For `.landscapeLeft`, `.landscapeRight`: return true
Any other status: test `UIScreen.main.bounds.height` against `UIScreen.main.bounds.weight`

### public func hkIsPortrait() -> Bool ###

Uses `UIDevice.current.orientation`:
For `.portrait`, `.portraitUpsideDown`: return true
For `.landscapeLeft`, `.landscapeRight`: return false
Any other status: test `UIScreen.main.bounds.height` against `UIScreen.main.bounds.weight`

### public func hkScreenHeight() -> CGFloat ###

Return `UIScreen.main.bounds.height`

### public func hkScreenWidth() -> CGFloat ###

Return `UIScreen.main.bounds.width`

### public func hkScreenLongerEdge() -> CGFloat ###

Returns the longer of `UIScreen.main.bounds.width` and `UIScreen.main.bounds.height`

### public func hkScreenShorterEdge() -> CGFloat ###

Returns the shorter of `UIScreen.main.bounds.width` and `UIScreen.main.bounds.height`

### public func hkScreenSize() -> CGSize ###

Return a CGSize made up of `UIScreen.main.bounds.width` and `UIScreen.main.bounds.height`

## INSTALLATION

This will be automatically included by other HK modules or CocoaPods.

### TO USE IT IN YOUR OWN PROJECT 

Just include the HKDeviceUtilities.swift file in your project or use CocoaPod. Don't forget to import the module if you are using CocoaPod:

```
  import HKDeviceUtilities
```
